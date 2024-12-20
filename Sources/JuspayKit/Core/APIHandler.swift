import AsyncHTTPClient
import Foundation
import NIO
import NIOFoundationCompat
import NIOHTTP1

/// The base URL for the Juspay API in production environment.
let APIBase = "https://api.juspay.in/"

/// The base URL for the Juspay API in sandbox environment.
let SandboxAPIBase = "https://sandbox.juspay.in/"

/// The base URL for the Juspay health status API.
let HealthStatusAPIBase = "https://status.juspay.in/"

public extension HTTPClientRequest.Body {
    /// Creates a request body from a string.
    ///
    /// - Parameter string: The string to be used as the request body.
    /// - Returns: An `HTTPClientRequest.Body` instance.
    static func string(_ string: String) -> Self {
        .bytes(.init(string: string))
    }

    /// Creates a request body from Data.
    ///
    /// - Parameter data: The Data to be used as the request body.
    /// - Returns: An `HTTPClientRequest.Body` instance.
    static func data(_ data: Data) -> Self {
        .bytes(.init(data: data))
    }
}

/// Represents the environment for the Juspay API.
public enum Environment: Sendable {
    /// The production environment.
    case production
    /// The sandbox environment for testing.
    case sandbox

    /// The base URL for the selected environment.
    var baseUrl: String {
        switch self {
        case .production:
            return APIBase
        case .sandbox:
            return SandboxAPIBase
        }
    }
}

/// Handles API requests to the Juspay payment gateway.
///
/// The `JuspayAPIHandler` is responsible for making HTTP requests to Juspay's API endpoints.
/// It handles authentication, request construction, and response parsing.
///
/// ## Topics
///
/// ### Making Requests
/// - ``send(_:method:path:query:body:headers:)``
///
/// ### Environment Configuration  
/// - ``Environment``
/// - ``Environment/production``
/// - ``Environment/sandbox``
///
/// ### Example
/// ```swift
/// let handler = JuspayAPIHandler(
///     httpClient: client,
///     apiKey: "key",
///     merchantId: "merchant",
///     environment: .sandbox
/// )
///
/// let response: PaymentMethodsResponse = try await handler.send(
///     method: .GET,
///     path: "merchants/guest/paymentmethods",
///     headers: headers
/// )
/// ```
actor JuspayAPIHandler {
    /// The HTTP client used for network requests.
    private let httpClient: HTTPClient
    /// The API key for authentication.
    private let apiKey: String
    /// The merchant ID associated with the Juspay account.
    private let merchantId: String
    /// The environment (production or sandbox) for API requests.
    private let environment: Environment
    /// JSON decoder for parsing API responses.
    private let decoder = JSONDecoder()

    /// Initializes a new instance of the JuspayAPIHandler.
    ///
    /// - Parameters:
    ///   - httpClient: The HTTP client to use for network requests.
    ///   - apiKey: The API key for authenticating with the Juspay API.
    ///   - merchantId: The unique identifier for the merchant.
    ///   - environment: The environment to use for API requests.
    init(
        httpClient: HTTPClient, apiKey: String, merchantId: String, environment: Environment
    ) {
        self.httpClient = httpClient
        self.apiKey = apiKey
        self.merchantId = merchantId
        self.environment = environment
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    /// Sends an API request to the Juspay service.
    ///
    /// - Parameters:
    ///   - method: The HTTP method for the request.
    ///   - path: The path component of the API endpoint.
    ///   - query: The query string for the request URL.
    ///   - body: The body of the HTTP request.
    ///   - headers: Additional headers to be included in the request.
    /// - Returns: A decoded object of type `T` representing the API response.
    /// - Throws: An error if the request fails or if the response cannot be decoded.
    func send<T: Codable>(
        healthCheck: Bool? = false,
        method: HTTPMethod,
        path: String,
        query: String = "",
        body: HTTPClientRequest.Body = .bytes(.init(string: "")),
        headers: HTTPHeaders
    ) async throws -> T {
        let baseURL: String = healthCheck == true ? HealthStatusAPIBase : environment.baseUrl
        var _headers: HTTPHeaders = [
            "x-merchantid": merchantId,
            "Content-Type": "application/x-www-form-urlencoded",
        ]
    
        headers.forEach { _headers.replaceOrAdd(name: $0.name, value: $0.value) }

        var request = HTTPClientRequest(url: "\(baseURL)\(path)?\(query)")
        request.headers = _headers
        request.setBasicAuth(username: apiKey, password: "")
        request.method = method
        request.body = body
        
        let response = try await httpClient.execute(request, timeout: .seconds(60))
        let responseData = try await response.body.collect(upTo:  1024 * 1024 * 100) // 500mb to account for data downloads.

        guard response.status == .ok else {
            let error = try decoder.decode(JuspayError.self, from: responseData)
            throw error
        }

        return try decoder.decode(T.self, from: responseData)
    }
}

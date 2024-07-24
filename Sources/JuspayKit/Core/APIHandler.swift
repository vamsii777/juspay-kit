import Foundation
import NIO
import NIOFoundationCompat
import NIOHTTP1
import AsyncHTTPClient

internal let APIBase = "https://api.juspay.in/"
internal let SandboxAPIBase = "https://sandbox.juspay.in/"

extension HTTPClientRequest.Body {
    public static func string(_ string: String) -> Self {
        .bytes(.init(string: string))
    }
    
    public static func data(_ data: Data) -> Self {
        .bytes(.init(data: data))
    }
}

public enum Environment {
    case production
    case sandbox
    
    var baseUrl: String {
        switch self {
        case .production:
            return APIBase
        case .sandbox:
            return SandboxAPIBase
        }
    }
}

struct JuspayAPIHandler {
    private let httpClient: HTTPClient
    private let apiKey: String
    private let merchantId: String
    private let environment: Environment
    private let decoder = JSONDecoder()
    
    init(httpClient: HTTPClient, apiKey: String, merchantId: String, environment: Environment) {
        self.httpClient = httpClient
        self.apiKey = apiKey
        self.merchantId = merchantId
        self.environment = environment
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func send<T: Codable>(method: HTTPMethod,
                          path: String,
                          query: String = "",
                          body: HTTPClientRequest.Body = .bytes(.init(string: "")),
                          headers: HTTPHeaders) async throws -> T {
        
        let baseURL = environment.baseUrl
        var _headers: HTTPHeaders = [
            "x-merchantid": merchantId,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let authString = "\(apiKey):".data(using: .utf8)!.base64EncodedString()
        _headers.add(name: "Authorization", value: "Basic \(authString)")
        
        headers.forEach { _headers.replaceOrAdd(name: $0.name, value: $0.value) }
        
        var request = HTTPClientRequest(url: "\(baseURL)\(path)?\(query)")
        request.headers = _headers
        request.method = method
        request.body = body
        
        let response = try await httpClient.execute(request, timeout: .seconds(60))
        let responseData = try await response.body.collect(upTo: 1024 * 1024 * 100)
        
        guard response.status == .ok else {
            let error = try self.decoder.decode(JuspayError.self, from: responseData)
            throw error
        }
        return try self.decoder.decode(T.self, from: responseData)
    }
}

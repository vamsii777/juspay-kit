import Foundation
import NIO
import NIOHTTP1

/// Protocol defining session API routes.
///
/// The `SessionRoutes` protocol provides methods for creating payment sessions
/// through Juspay's payment gateway.
///
/// ## Topics
///
/// ### Creating Sessions
/// - ``create(session:)``
///
/// ### Session Types
/// - ``Session``
/// - ``SessionAction``
/// - ``SessionResponse``
///
/// ### Example
///
/// ```swift
/// // Create a new payment session
/// let session = Session(
///     orderId: "ORDER123",
///     amount: "100.00", 
///     customerId: "CUST123",
///     customerEmail: "customer@example.com",
///     customerPhone: "1234567890",
///     paymentPageClientId: merchantId,
///     action: .paymentPage,
///     returnUrl: "https://merchant.com/return"
/// )
///
/// let response = try await client.sessions.create(session: session)
///
/// // Access session details
/// print("Session ID: \(response.id)")
/// print("Client Auth Token: \(response.clientAuthToken)")
/// ```
public protocol SessionRoutes: JuspayAPIRoute {
    /// Creates a new session with the provided session information.
    ///
    /// - Parameter session: The `Session` object containing the necessary information to create a new session.
    /// - Returns: A `SessionResponse` object containing the response from the session creation request.
    /// - Throws: An error if the session creation fails or if there's an issue with the network request.
    func create(session: Session) async throws -> SessionResponse
}

/// A concrete implementation of the `SessionRoutes` protocol for interacting with Juspay's session-related API endpoints.
public struct JuspaySessionRoutes: SessionRoutes {
    /// The HTTP headers to be included in the API requests.
    public var headers: HTTPHeaders = [:]

    /// The API handler responsible for making network requests to the Juspay API.
    private let apiHandler: JuspayAPIHandler

    /// Initializes a new instance of `JuspaySessionRoutes`.
    ///
    /// - Parameter apiHandler: The `JuspayAPIHandler` to be used for making API requests.
    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }

    /// Creates a new session by sending a POST request to the Juspay API.
    ///
    /// This method encodes the provided `Session` object into JSON and sends it to the "/session" endpoint.
    ///
    /// - Parameter session: The `Session` object containing the information for creating a new session.
    /// - Returns: A `SessionResponse` object containing the response from the session creation request.
    /// - Throws: An error if the JSON encoding fails, if the network request fails, or if the API returns an error.
    public func create(session: Session) async throws -> SessionResponse {
        let body = try JSONEncoder().encode(session)
        var _headers = headers
        _headers.add(name: "Content-Type", value: "application/json")
        return try await apiHandler.send(method: .POST, path: "session", body: .data(body), headers: _headers)
    }
}

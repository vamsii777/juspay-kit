import Foundation
import NIO
import NIOHTTP1

/// A protocol defining the routes for session-related operations in the Juspay API.
///
/// This protocol extends `JuspayAPIRoute` and provides a method for creating a new session.
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
        return try await apiHandler.send(method: .POST, path: "session", body: .data(body), headers: headers)
    }
}

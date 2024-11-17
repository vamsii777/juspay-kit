import Foundation
import NIO
import NIOHTTP1

/// A protocol defining the order-related API routes for the Juspay payment gateway.
///
/// This protocol extends `JuspayAPIRoute` and provides methods for creating and retrieving order information.
public protocol OrderRoutes: JuspayAPIRoute {
    /// Retrieves an existing order from the Juspay system.
    ///
    /// - Parameter orderId: The unique identifier of the order in the Juspay system.
    ///
    /// - Returns: An `Order` object representing the retrieved order.
    ///
    /// - Throws: An error if the order retrieval fails or if there's a network issue.
    func retrieve(orderId: String) async throws -> Order

    /// Creates a new order in the Juspay system.
    ///
    /// - Parameter parameters: A dictionary containing the necessary parameters for order creation.
    ///   The specific keys and values required may vary based on the Juspay API documentation.
    ///
    /// - Returns: An `OrderCreationResponse` object representing the newly created order.
    ///
    /// - Throws: An error if the order creation fails, if there's a network issue, or if the input is invalid.
    func create(parameters: [String: Any]) async throws -> OrderCreationResponse
}

/// A concrete implementation of the `OrderRoutes` protocol for interacting with Juspay's order API.
public struct JuspayOrderRoutes: OrderRoutes {
    /// The HTTP headers to be sent with each request.
    public var headers: HTTPHeaders = [:]

    /// The API handler responsible for making network requests.
    private let apiHandler: JuspayAPIHandler

    /// Initializes a new instance of `JuspayOrderRoutes`.
    ///
    /// - Parameter apiHandler: The `JuspayAPIHandler` instance to use for API requests.
    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }

    /// Retrieves an existing order from the Juspay system.
    ///
    /// This method sends a GET request to the Juspay API to retrieve the order with the specified ID.
    ///
    /// - Parameter orderId: The unique identifier of the order in the Juspay system.
    ///
    /// - Returns: An `Order` object representing the retrieved order.
    ///
    /// - Throws: An error if the order retrieval fails or if there's a network issue.
    public func retrieve(orderId: String) async throws -> Order {
        var _headers = headers
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: currentDate)
        _headers.add(name: "version", value: formattedDate)
        return try await apiHandler.send(method: .GET, path: "orders/\(orderId)", headers: _headers)
    }

    /// Creates a new order in the Juspay system.
    ///
    /// This method sends a POST request to the Juspay API to create a new order with the provided parameters.
    ///
    /// - Parameter parameters: A dictionary containing the necessary parameters for order creation.
    ///   The specific keys and values required may vary based on the Juspay API documentation.
    ///
    /// - Returns: An `OrderCreationResponse` object representing the newly created order.
    ///
    /// - Throws: A `JuspayError` if the order creation fails, if there's a network issue, or if the input is invalid.
    ///   The specific error thrown depends on the nature of the failure:
    ///   - `.orderCreationFailed`: If the order creation fails due to invalid input or other reasons.
    ///   - `.authenticationFailed`: If the API request fails due to authentication issues.
    ///   - `.serverError`: If the server encounters an error during order creation.
    public func create(parameters: [String: Any]) async throws -> OrderCreationResponse {
        return try await apiHandler.send(method: .POST, path: "orders", body: .string(parameters.percentEncoded()), headers: headers)
    }
}

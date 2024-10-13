import Foundation
import NIO
import NIOHTTP1

/// A protocol defining the refund-related API routes for the Juspay payment gateway.
///
/// This protocol extends `JuspayAPIRoute` and provides methods for creating refund requests.
public protocol RefundRoutes: JuspayAPIRoute {
    /// Creates a new refund request for a specific order.
    ///
    /// - Parameters:
    ///   - orderId: The unique identifier of the order for which the refund is being requested.
    ///   - refund: A `RefundRequest` object containing the details of the refund request.
    ///
    /// - Returns: A `RefundResponse` object representing the result of the refund request.
    ///
    /// - Throws: An error if the refund creation fails or if there's a network issue.
    func create(orderId: String, refund: RefundRequest) async throws -> RefundResponse
}

/// A concrete implementation of the `RefundRoutes` protocol for interacting with Juspay's refund API.
public struct JuspayRefundRoutes: RefundRoutes {
    /// The HTTP headers to be sent with each request.
    public var headers: HTTPHeaders = [:]

    /// The API handler responsible for making network requests.
    private let apiHandler: JuspayAPIHandler

    /// Initializes a new instance of `JuspayRefundRoutes`.
    ///
    /// - Parameter apiHandler: The `JuspayAPIHandler` instance to use for API requests.
    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }

    /// Creates a new refund request for a specific order.
    ///
    /// This method constructs the necessary request body and headers, then sends a POST request
    /// to the Juspay API to create a new refund for the specified order.
    ///
    /// - Parameters:
    ///   - orderId: The unique identifier of the order for which the refund is being requested.
    ///   - refund: A `RefundRequest` object containing the details of the refund request.
    ///
    /// - Returns: A `RefundResponse` object representing the result of the refund request.
    ///
    /// - Throws: An error if the refund creation fails or if there's a network issue.
    public func create(orderId: String, refund: RefundRequest) async throws -> RefundResponse {
        let path = "orders/\(orderId)/refunds"
        var body = "unique_request_id=\(refund.uniqueRequestId)&amount=\(refund.amount)"
        body = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? body
        
        var _headers = headers
        _headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
        _headers.add(name: "version", value: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none))
        
        return try await apiHandler.send(method: .POST, path: path, body: .string(body), headers: _headers)
    }
}

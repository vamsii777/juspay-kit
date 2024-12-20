import JuspayKit
import Foundation
import NIOHTTP1

/// Protocol defining HyperCheckout refund-related operations.
///
/// The `HyperRefundRoutes` protocol provides methods for processing refunds
/// through Juspay's HyperCheckout solution.
///
/// ## Topics
///
/// ### Processing Refunds
/// - ``request(orderId:routingId:refund:)``
///
/// ### Example
///
/// ```swift
/// // Create a refund request
/// let refundRequest = RefundRequest(
///     uniqueRequestId: "REFUND123",
///     amount: 50.00,
///     reason: "Customer request"
/// )
///
/// // Process the refund
/// let response = try await hyperCheckout.refunds.request(
///     orderId: "ORDER123",
///     routingId: "CUSTOMER456",
///     refund: refundRequest
/// )
///
/// print("Refund Status: \(response.status)")
/// ```
public protocol HyperRefundRoutes: Sendable {
    /// Requests a refund for an order.
    ///
    /// - Parameters:
    ///   - orderId: The unique identifier of the order to refund.
    ///   - routingId: The routing identifier (typically the customer ID).
    ///   - refund: The refund request details.
    /// - Returns: A `RefundResponse` containing the refund status.
    /// - Throws: An error if the refund request fails.
    func request(orderId: String, routingId: String, refund: RefundRequest) async throws -> RefundResponse
}

public struct DefaultHyperRefundRoutes: HyperRefundRoutes {
    private let juspayClient: JuspayClient
    
    init(juspayClient: JuspayClient) {
        self.juspayClient = juspayClient
    }
    
    public func request(orderId: String, routingId: String, refund: RefundRequest) async throws -> RefundResponse {
        return try await juspayClient.refunds.create(orderId: orderId, routingId: routingId, refund: refund)
    }
} 
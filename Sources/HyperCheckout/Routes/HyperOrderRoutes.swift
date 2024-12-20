import JuspayKit
import Foundation
import NIOHTTP1

/// Protocol defining HyperCheckout order-related operations.
///
/// The `HyperOrderRoutes` protocol provides methods for managing orders
/// through Juspay's HyperCheckout solution.
///
/// ## Topics
///
/// ### Checking Order Status
/// - ``status(orderId:routingId:)``
///
/// ### Example
///
/// ```swift
/// // Check the status of an order
/// let order = try await hyperCheckout.orders.status(
///     orderId: "ORDER123",
///     routingId: "CUSTOMER456"
/// )
///
/// print("Order Status: \(order.status)")
/// ```
public protocol HyperOrderRoutes {
    /// Retrieves the status of an order.
    ///
    /// - Parameters:
    ///   - orderId: The unique identifier of the order.
    ///   - routingId: The routing identifier (typically the customer ID).
    /// - Returns: An `Order` object containing the current status.
    /// - Throws: An error if the status check fails.
    func status(orderId: String, routingId: String) async throws -> Order
}

public struct DefaultHyperOrderRoutes: HyperOrderRoutes {
    private let juspayClient: JuspayClient
    
    init(juspayClient: JuspayClient) {
        self.juspayClient = juspayClient
    }
    
    public func status(orderId: String, routingId: String) async throws -> Order {
        return try await juspayClient.orders.retrieve(orderId: orderId, routingId: routingId)
    }
}

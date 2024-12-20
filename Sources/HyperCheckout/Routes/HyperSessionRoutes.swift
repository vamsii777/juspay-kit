import JuspayKit
import Foundation
import NIOHTTP1

/// Protocol defining HyperCheckout session-related operations.
///
/// The `HyperSessionRoutes` protocol provides methods for managing payment sessions
/// through Juspay's HyperCheckout solution.
///
/// ## Topics
///
/// ### Creating Sessions
/// - ``create(session:)``
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
/// let response = try await hyperCheckout.sessions.create(session: session)
/// ```
public protocol HyperSessionRoutes {
    /// Creates a new payment session.
    ///
    /// - Parameter session: The session configuration.
    /// - Returns: A `SessionResponse` containing the created session details.
    /// - Throws: An error if session creation fails.
    func create(session: Session) async throws -> SessionResponse
}

public struct DefaultHyperSessionRoutes: HyperSessionRoutes {
    private let juspayClient: JuspayClient
    
    init(juspayClient: JuspayClient) {
        self.juspayClient = juspayClient
    }
    
    public func create(session: Session) async throws -> SessionResponse {
        return try await juspayClient.sessions.create(session: session)
    }
}
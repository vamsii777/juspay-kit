import JuspayKit
import AsyncHTTPClient
import Foundation

/// A client for interacting with Juspay's HyperCheckout payment solution.
///
/// The `HyperCheckoutClient` provides a simplified interface for integrating Juspay's HyperCheckout
/// payment solution into your application. It wraps the core JuspayKit functionality with
/// HyperCheckout-specific implementations.
///
/// ## Topics
///
/// ### Creating a Client
/// - ``init(_:)``
///
/// ### Available Routes
/// - ``orders``
/// - ``sessions``
/// - ``refunds``
///
/// ### Example
///
/// ```swift
/// // Initialize the base Juspay client
/// let juspayClient = JuspayClient(
///     httpClient: HTTPClient.shared,
///     apiKey: "your_api_key",
///     merchantId: "your_merchant_id",
///     environment: .sandbox
/// )
///
/// // Create the HyperCheckout client
/// let hyperCheckout = HyperCheckoutClient(juspayClient)
///
/// // Create a payment session
/// let session = Session(
///     orderId: "ORDER123",
///     amount: "100.00",
///     customerId: "CUST123",
///     customerEmail: "customer@example.com",
///     customerPhone: "1234567890",
///     paymentPageClientId: merchantId,
///     action: .paymentPage,
///     returnUrl: "https://your-return-url.com"
/// )
///
/// let response = try await hyperCheckout.sessions.create(session: session)
/// ```
public actor HyperCheckoutClient {
    /// The underlying JuspayClient instance.
    private let juspayClient: JuspayClient
    
    /// Routes for order-related operations.
    public let orders: any HyperOrderRoutes
    
    /// Routes for session-related operations.
    public let sessions: any HyperSessionRoutes
    
    /// Routes for refund-related operations.
    public let refunds: any HyperRefundRoutes
    
    /// Creates a new HyperCheckout client.
    ///
    /// - Parameter juspayClient: A configured JuspayClient instance.
    public init(_ juspayClient: JuspayClient) {
        self.juspayClient = juspayClient
        self.orders = DefaultHyperOrderRoutes(juspayClient: juspayClient)
        self.sessions = DefaultHyperSessionRoutes(juspayClient: juspayClient)
        self.refunds = DefaultHyperRefundRoutes(juspayClient: juspayClient)
    }
}

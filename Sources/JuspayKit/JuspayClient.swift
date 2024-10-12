import AsyncHTTPClient
import Foundation
import NIO

/// A client for interacting with the Juspay API.
///
/// The `JuspayClient` provides a thread-safe, concurrent interface to access various Juspay API endpoints,
/// including customers, orders, payment methods, sessions, and refunds.
///
/// - Important: This client requires proper initialization with valid credentials and an HTTP client.
///
/// ## Topics
///
/// ### Initializing the Client
/// - ``init(httpClient:apiKey:merchantId:environment:)``
///
/// ### API Routes
/// - ``customers``
/// - ``orders``
/// - ``paymentMethods``
/// - ``sessions``
/// - ``refunds``
///
/// ### Supporting Types
/// - ``Environment``
public actor JuspayClient {
    /// The route for customer-related operations.
    public let customers: JuspayCustomerRoutes
    /// The route for order-related operations.
    public let orders: JuspayOrderRoutes
    /// The route for payment method-related operations.
    public let paymentMethods: JuspayPaymentMethodRoutes
    /// The route for session-related operations.
    public let sessions: JuspaySessionRoutes
    /// The route for refund-related operations.
    public let refunds: JuspayRefundRoutes
    /// The route for health check-related operations.
    public let health: JuspayHealthRoutes

    private let apiHandler: JuspayAPIHandler

    /// Initializes a new instance of the Juspay client.
    ///
    /// - Parameters:
    ///   - httpClient: The HTTP client to use for network requests.
    ///   - apiKey: The API key for authenticating with the Juspay API.
    ///   - merchantId: The unique identifier for the merchant.
    ///   - environment: The environment to use for API requests (e.g., production or sandbox).
    ///
    /// - Important: Ensure that you keep your API key secure and do not expose it in client-side code.
    public init(httpClient: HTTPClient, apiKey: String, merchantId: String, environment: Environment) {
        apiHandler = JuspayAPIHandler(httpClient: httpClient, apiKey: apiKey, merchantId: merchantId, environment: environment)
        customers = JuspayCustomerRoutes(apiHandler: apiHandler)
        orders = JuspayOrderRoutes(apiHandler: apiHandler)
        paymentMethods = JuspayPaymentMethodRoutes(apiHandler: apiHandler)
        sessions = JuspaySessionRoutes(apiHandler: apiHandler)
        refunds = JuspayRefundRoutes(apiHandler: apiHandler)
        health = JuspayHealthRoutes(apiHandler: apiHandler)
    }
}

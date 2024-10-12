public final class JuspayClient {
    public var customers: JuspayCustomerRoutes
    public var orders: JuspayOrderRoutes
    public var paymentMethods: JuspayPaymentMethodRoutes
    public var sessions: JuspaySessionRoutes
    public var refunds: JuspayRefundRoutes
    private let apiHandler: JuspayAPIHandler
    
    public init(httpClient: HTTPClient, apiKey: String, merchantId: String, environment: Environment) {
        apiHandler = JuspayAPIHandler(httpClient: httpClient, apiKey: apiKey, merchantId: merchantId, environment: environment)
        customers = JuspayCustomerRoutes(apiHandler: apiHandler)
        orders = JuspayOrderRoutes(apiHandler: apiHandler)
        paymentMethods = JuspayPaymentMethodRoutes(apiHandler: apiHandler)
        sessions = JuspaySessionRoutes(apiHandler: apiHandler)
        refunds = JuspayRefundRoutes(apiHandler: apiHandler)
    }
}

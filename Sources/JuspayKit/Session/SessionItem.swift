import Foundation

public enum SessionAction: String, Codable, Sendable {
    case paymentPage
    case paymentManagement
}

public struct Session: Codable, Sendable {
    public let orderId: String
    public let amount: String
    public let customerId: String
    public let customerEmail: String
    public let customerPhone: String
    public let paymentPageClientId: String
    public let action: SessionAction
    public let returnUrl: String
    public let description: String?
    public let firstName: String?
    public let lastName: String?
    public let currency: String?
    public let metadata: [String: String]?
    public let options: Options?

    public init(orderId: String, amount: String, customerId: String, customerEmail: String, customerPhone: String, paymentPageClientId: String, action: SessionAction, returnUrl: String, description: String? = nil, firstName: String? = nil, lastName: String? = nil, currency: String? = nil, metadata: [String: String]? = nil, options: Options? = nil) {
        self.orderId = orderId
        self.amount = amount
        self.customerId = customerId
        self.customerEmail = customerEmail
        self.customerPhone = customerPhone
        self.paymentPageClientId = paymentPageClientId
        self.action = action
        self.returnUrl = returnUrl
        self.description = description
        self.firstName = firstName
        self.lastName = lastName
        self.currency = currency
        self.metadata = metadata
        self.options = options
    }

    private enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case amount
        case customerId = "customer_id"
        case customerEmail = "customer_email"
        case customerPhone = "customer_phone"
        case paymentPageClientId = "payment_page_client_id"
        case action
        case returnUrl = "return_url"
        case description
        case firstName = "first_name"
        case lastName = "last_name"
        case currency
        case metadata
        case options
    }

    public struct Options: Codable, Sendable {
        public let createMandate: String?
        public let mandateMaxAmount: String?
        public let mandateStartDate: String?
        public let mandateEndDate: String?
        public let mandateFrequency: String?
        public let mandateRuleValue: String?
        public let mandateAmountRule: String?
        public let mandateBlockFunds: Bool?

        public init(createMandate: String? = nil, mandateMaxAmount: String? = nil, mandateStartDate: String? = nil, mandateEndDate: String? = nil, mandateFrequency: String? = nil, mandateRuleValue: String? = nil, mandateAmountRule: String? = nil, mandateBlockFunds: Bool? = nil) {
            self.createMandate = createMandate
            self.mandateMaxAmount = mandateMaxAmount
            self.mandateStartDate = mandateStartDate
            self.mandateEndDate = mandateEndDate
            self.mandateFrequency = mandateFrequency
            self.mandateRuleValue = mandateRuleValue
            self.mandateAmountRule = mandateAmountRule
            self.mandateBlockFunds = mandateBlockFunds
        }

        private enum CodingKeys: String, CodingKey {
            case createMandate = "create_mandate"
            case mandateMaxAmount = "mandate_max_amount"
            case mandateStartDate = "mandate_start_date"
            case mandateEndDate = "mandate_end_date"
            case mandateFrequency = "mandate_frequency"
            case mandateRuleValue = "mandate_rule_value"
            case mandateAmountRule = "mandate_amount_rule"
            case mandateBlockFunds = "mandate_block_funds"
        }
    }
}

public struct SessionResponse: Codable, Sendable {
    public let status: String
    public let id: String
    public let orderId: String
    public let paymentLinks: PaymentLinks
    public let sdkPayload: SDKPayload

    public init(status: String, id: String, orderId: String, paymentLinks: PaymentLinks, sdkPayload: SDKPayload) {
        self.status = status
        self.id = id
        self.orderId = orderId
        self.paymentLinks = paymentLinks
        self.sdkPayload = sdkPayload
    }
}

public struct PaymentLinks: Codable, Sendable {
    public let web: String?
    public let mobile: String?
    public let expiry: String?

    private enum CodingKeys: String, CodingKey {
        case web
        case mobile
        case expiry
    }

    public init(web: String, mobile: String? = nil, expiry: String? = nil) {
        self.web = web
        self.mobile = mobile
        self.expiry = expiry
    }
}

public struct SDKPayload: Codable, Sendable {
    public let requestId: String?
    public let service: String?
    public let payload: Payload?

    private enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case service
        case payload
    }

    public init(requestId: String, service: String, payload: Payload? = nil) {
        self.requestId = requestId
        self.service = service
        self.payload = payload
    }
}

public struct Payload: Codable, Sendable {
    public let clientId: String?
    public let amount: String?
    public let merchantId: String?
    public let clientAuthToken: String?
    public let clientAuthTokenExpiry: String?
    public let environment: String?
    public let optionsGetUpiDeepLinks: String?
    public let lastName: String?
    public let action: SessionAction?
    public let customerId: String?
    public let returnUrl: String?
    public let currency: String?
    public let firstName: String?
    public let customerPhone: String?
    public let customerEmail: String?
    public let orderId: String?
    public let service: String?
    public let description: String?

    private enum CodingKeys: String, CodingKey {
        case clientId = "client_id"
        case amount
        case merchantId = "merchant_id"
        case clientAuthToken = "client_auth_token"
        case clientAuthTokenExpiry = "client_auth_token_expiry"
        case environment
        case optionsGetUpiDeepLinks = "options_get_upi_deep_links"
        case lastName = "last_name"
        case action
        case customerId = "customer_id"
        case returnUrl = "return_url"
        case currency
        case firstName = "first_name"
        case customerPhone = "customer_phone"
        case customerEmail = "customer_email"
        case orderId = "order_id"
        case service
        case description
    }

    public init(clientId: String? = nil, amount: String? = nil, merchantId: String? = nil, clientAuthToken: String? = nil, clientAuthTokenExpiry: String? = nil, environment: String? = nil, optionsGetUpiDeepLinks: String? = nil, lastName: String? = nil, action: SessionAction? = nil, customerId: String? = nil, returnUrl: String? = nil, currency: String? = nil, firstName: String? = nil, customerPhone: String? = nil, customerEmail: String? = nil, orderId: String? = nil, service: String? = nil, description: String? = nil) {
        self.clientId = clientId
        self.amount = amount
        self.merchantId = merchantId
        self.clientAuthToken = clientAuthToken
        self.clientAuthTokenExpiry = clientAuthTokenExpiry
        self.environment = environment
        self.optionsGetUpiDeepLinks = optionsGetUpiDeepLinks
        self.lastName = lastName
        self.action = action
        self.customerId = customerId
        self.returnUrl = returnUrl
        self.currency = currency
        self.firstName = firstName
        self.customerPhone = customerPhone
        self.customerEmail = customerEmail
        self.orderId = orderId
        self.service = service
        self.description = description
    }
}

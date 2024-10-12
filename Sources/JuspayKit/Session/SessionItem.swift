import Foundation

public enum SessionAction: String, Codable {
    case paymentPage = "paymentPage"
    case paymentManagement = "paymentManagement"
}

/// A structure representing a payment session in the Juspay system.
///
/// This struct encapsulates all the necessary information to initiate a payment session,
/// including customer details, order information, and optional mandate settings.
public struct Session: Codable, Sendable {
    /// The unique identifier for the order associated with this session.
    public let orderId: String

    /// The total amount for the transaction, represented as a string.
    public let amount: String

    /// The unique identifier for the customer.
    public let customerId: String

    /// The email address of the customer.
    public let customerEmail: String

    /// The phone number of the customer.
    public let customerPhone: String

    /// The client ID for the payment page.
    public let paymentPageClientId: String

    /// The action to be performed in this session.
    public let action: SessionAction

    /// The URL to which the customer will be redirected after the payment process.
    public let returnUrl: String

    /// An optional description of the transaction.
    public let description: String?

    /// The optional first name of the customer.
    public let firstName: String?

    /// The optional last name of the customer.
    public let lastName: String?

    /// The optional currency code for the transaction.
    public let currency: String?

    /// Optional additional metadata associated with the session.
    public let metadata: [String: String]?

    /// Optional settings for creating a mandate.
    public let options: Options?

    /// Initializes a new instance of the `Session` struct.
    ///
    /// - Parameters:
    ///   - orderId: The unique identifier for the order associated with this session.
    ///   - amount: The total amount for the transaction, represented as a string.
    ///   - customerId: The unique identifier for the customer.
    ///   - customerEmail: The email address of the customer.
    ///   - customerPhone: The phone number of the customer.
    ///   - paymentPageClientId: The client ID for the payment page.
    ///   - action: The action to be performed in this session.
    ///   - returnUrl: The URL to which the customer will be redirected after the payment process.
    ///   - description: An optional description of the transaction.
    ///   - firstName: The optional first name of the customer.
    ///   - lastName: The optional last name of the customer.
    ///   - currency: The optional currency code for the transaction.
    ///   - metadata: Optional additional metadata associated with the session.
    ///   - options: Optional settings for creating a mandate.
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

    /// A structure representing options for creating a mandate.
    public struct Options: Codable, Sendable {
        /// Indicates whether to create a mandate for this session.
        public let createMandate: String?

        /// The maximum amount allowed for the mandate.
        public let mandateMaxAmount: String?

        /// The start date of the mandate.
        public let mandateStartDate: String?

        /// The end date of the mandate.
        public let mandateEndDate: String?

        /// The frequency of the mandate (e.g., "DAILY", "WEEKLY", "MONTHLY").
        public let mandateFrequency: String?

        /// The value associated with the mandate rule.
        public let mandateRuleValue: String?

        /// The rule for the mandate amount.
        public let mandateAmountRule: String?

        /// Indicates whether to block funds for the mandate.
        public let mandateBlockFunds: Bool?

        /// Initializes a new instance of the `Options` struct.
        ///
        /// - Parameters:
        ///   - createMandate: Indicates whether to create a mandate for this session.
        ///   - mandateMaxAmount: The maximum amount allowed for the mandate.
        ///   - mandateStartDate: The start date of the mandate.
        ///   - mandateEndDate: The end date of the mandate.
        ///   - mandateFrequency: The frequency of the mandate (e.g., "DAILY", "WEEKLY", "MONTHLY").
        ///   - mandateRuleValue: The value associated with the mandate rule.
        ///   - mandateAmountRule: The rule for the mandate amount.
        ///   - mandateBlockFunds: Indicates whether to block funds for the mandate.
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
    }
}

/// A structure representing the response received after creating a session.
public struct SessionResponse: Codable, Sendable {
    /// The status of the session creation request.
    public let status: String

    /// The unique identifier for the created session.
    public let id: String

    /// The order ID associated with this session.
    public let orderId: String

    /// Links related to the payment process.
    public let paymentLinks: PaymentLinks

    /// Payload for SDK integration.
    public let sdkPayload: SDKPayload

    /// A structure containing payment-related links.
    public struct PaymentLinks: Codable, Sendable {
        /// The URL for web-based payment.
        public let web: String
    }

    /// A structure containing payload information for SDK integration.
    public struct SDKPayload: Codable, Sendable {
        /// The unique identifier for this request.
        public let requestId: String

        /// The service being used (e.g., "in.juspay.hyperpay").
        public let service: String

        /// The main payload containing session details.
        public let payload: Payload

        /// A structure representing the detailed payload for SDK integration.
        public struct Payload: Codable, Sendable {
            /// The client ID for the payment.
            public let clientId: String

            /// The amount of the transaction.
            public let amount: String

            /// The ID of the merchant.
            public let merchantId: String

            /// The authentication token for the client.
            public let clientAuthToken: String

            /// The expiry time of the client authentication token.
            public let clientAuthTokenExpiry: String

            /// The environment in which the transaction is taking place (e.g., "sandbox", "production").
            public let environment: String

            /// Options for getting UPI deep links.
            public let optionsGetUpiDeepLinks: String

            /// The last name of the customer.
            public let lastName: String

            /// The action to be performed (e.g., "AUTHORIZE", "CAPTURE").
            public let action: String

            /// The unique identifier for the customer.
            public let customerId: String

            /// The URL to which the customer will be redirected after the payment process.
            public let returnUrl: String

            /// The currency code for the transaction.
            public let currency: String

            /// The first name of the customer.
            public let firstName: String

            /// The phone number of the customer.
            public let customerPhone: String

            /// The email address of the customer.
            public let customerEmail: String

            /// The unique identifier for the order.
            public let orderId: String

            /// A description of the transaction.
            public let description: String
        }
    }
}

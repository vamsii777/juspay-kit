import Foundation

public struct Session: Codable {
    public let orderId: String
    public let amount: String
    public let customerId: String
    public let customerEmail: String
    public let customerPhone: String
    public let paymentPageClientId: String
    public let action: String
    public let returnUrl: String
    public let description: String?
    public let firstName: String?
    public let lastName: String?
    public let currency: String?
    public let metadata: [String: String]?
    public let options: Options?

    public struct Options: Codable {
        public let createMandate: String?
        public let mandateMaxAmount: String?
        public let mandateStartDate: String?
        public let mandateEndDate: String?
        public let mandateFrequency: String?
        public let mandateRuleValue: String?
        public let mandateAmountRule: String?
        public let mandateBlockFunds: Bool?
    }
}

public struct SessionResponse: Codable {
    public let status: String
    public let id: String
    public let orderId: String
    public let paymentLinks: PaymentLinks
    public let sdkPayload: SDKPayload

    public struct PaymentLinks: Codable {
        public let web: String
    }

    public struct SDKPayload: Codable {
        public let requestId: String
        public let service: String
        public let payload: Payload

        public struct Payload: Codable {
            public let clientId: String
            public let amount: String
            public let merchantId: String
            public let clientAuthToken: String
            public let clientAuthTokenExpiry: String
            public let environment: String
            public let optionsGetUpiDeepLinks: String
            public let lastName: String
            public let action: String
            public let customerId: String
            public let returnUrl: String
            public let currency: String
            public let firstName: String
            public let customerPhone: String
            public let customerEmail: String
            public let orderId: String
            public let description: String
        }
    }
}

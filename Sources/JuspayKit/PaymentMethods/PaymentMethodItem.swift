import Foundation

public struct PaymentMethod: Codable {
    public let paymentMethodType: String
    public let paymentMethod: String
    public let description: String
}

public struct EmadatePaymentMethod: Codable {
    public let paymentMethods: [PaymentMethod]
}

public struct DirectWalletDebitSupportedPaymentMethod: Codable {
    public let paymentMethods: [PaymentMethod]
    public let walletDirectDebitSupport: Bool
}

public struct GatewayReferenceIDPaymentMethod: Codable {
    public let paymentMethods: [GatewayReferencePaymentMethod]
}

public struct GatewayReferencePaymentMethod: Codable {
    public let supportedReferenceIds: [String]
    public let paymentMethodType: String
    public let paymentMethod: String
    public let description: String
}

public struct OutagePaymentMethod: Codable {
    public let outage: [Outage]
}

public struct Outage: Codable {
    public let status: String
    public let paymentMethod: String
    public let paymentMethodType: String
    public let juspayBankCode: String
    public let description: String
}

public struct TPVPaymentMethod: Codable {
    public let tpvPaymentMethods: [PaymentMethod]
}

public struct PaymentMethodsResponse: Codable {
    public let paymentMethods: [PaymentMethod]
    public let emandatePaymentMethods: [PaymentMethod]?
    public let directWalletDebitSupportedPaymentMethods: [DirectWalletDebitSupportedPaymentMethod]?
    public let gatewayReferenceIDPaymentMethods: [GatewayReferenceIDPaymentMethod]?
    public let outages: [Outage]?
    public let tpvPaymentMethods: [TPVPaymentMethod]?
}
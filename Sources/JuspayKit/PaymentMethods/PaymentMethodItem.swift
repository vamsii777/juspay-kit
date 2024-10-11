import Foundation

/// A structure representing a payment method.
public struct PaymentMethod: Codable, Sendable {
    /// The type of the payment method.
    public let paymentMethodType: String
    
    /// The identifier of the payment method.
    public let paymentMethod: String
    
    /// A description of the payment method.
    public let description: String
}

/// A structure representing an e-mandate payment method.
public struct EmadatePaymentMethod: Codable, Sendable {
    /// An array of payment methods associated with e-mandate.
    public let paymentMethods: [PaymentMethod]
}

/// A structure representing a payment method that supports direct wallet debit.
public struct DirectWalletDebitSupportedPaymentMethod: Codable, Sendable {
    /// An array of payment methods that support direct wallet debit.
    public let paymentMethods: [PaymentMethod]
    
    /// A boolean indicating whether wallet direct debit is supported.
    public let walletDirectDebitSupport: Bool
}

/// A structure representing a payment method with gateway reference IDs.
public struct GatewayReferenceIDPaymentMethod: Codable, Sendable {
    /// An array of payment methods with gateway references.
    public let paymentMethods: [GatewayReferencePaymentMethod]
}

/// A structure representing a payment method with gateway reference details.
public struct GatewayReferencePaymentMethod: Codable, Sendable {
    /// An array of supported reference IDs.
    public let supportedReferenceIds: [String]
    
    /// The type of the payment method.
    public let paymentMethodType: String
    
    /// The identifier of the payment method.
    public let paymentMethod: String
    
    /// A description of the payment method.
    public let description: String
}

/// A structure representing payment methods that are currently experiencing outages.
public struct OutagePaymentMethod: Codable, Sendable {
    /// An array of outages affecting payment methods.
    public let outage: [Outage]
}

/// A structure representing an outage for a specific payment method.
public struct Outage: Codable, Sendable {
    /// The current status of the outage.
    public let status: String
    
    /// The identifier of the affected payment method.
    public let paymentMethod: String
    
    /// The type of the affected payment method.
    public let paymentMethodType: String
    
    /// The Juspay bank code associated with the outage.
    public let juspayBankCode: String
    
    /// A description of the outage.
    public let description: String
}

/// A structure representing TPV (Total Payment Volume) payment methods.
public struct TPVPaymentMethod: Codable, Sendable {
    /// An array of TPV payment methods.
    public let tpvPaymentMethods: [PaymentMethod]
}

/// A structure representing the response containing various payment method types.
public struct PaymentMethodsResponse: Codable, Sendable {
    /// An array of general payment methods.
    public let paymentMethods: [PaymentMethod]
    
    /// An optional array of e-mandate payment methods.
    public let emandatePaymentMethods: [PaymentMethod]?
    
    /// An optional array of payment methods supporting direct wallet debit.
    public let directWalletDebitSupportedPaymentMethods: [DirectWalletDebitSupportedPaymentMethod]?
    
    /// An optional array of payment methods with gateway reference IDs.
    public let gatewayReferenceIDPaymentMethods: [GatewayReferenceIDPaymentMethod]?
    
    /// An optional array of outages affecting payment methods.
    public let outages: [Outage]?
    
    /// An optional array of TPV payment methods.
    public let tpvPaymentMethods: [TPVPaymentMethod]?
}
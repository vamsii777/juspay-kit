import Foundation

/// A structure representing an order in the Juspay system.
///
/// This struct encapsulates all the relevant information about an order,
/// including its status, amount, customer details, and payment information.
public struct Order: Codable, Sendable {
    /// The unique identifier for the order in the Juspay system.
    public let id: String
    
    /// The order identifier provided by the merchant.
    public let orderId: String
    
    /// The current status of the order (e.g., "CHARGED", "PENDING").
    public let status: String
    
    /// The numeric representation of the order status.
    public let statusId: Int
    
    /// The total amount of the order.
    public let amount: Double
    
    /// The date and time when the order was created.
    public let dateCreated: Date
    
    /// The email address of the customer who placed the order.
    public let customerEmail: String
    
    /// The phone number of the customer who placed the order.
    public let customerPhone: String
    
    /// The unique identifier of the customer in the Juspay system.
    public let customerId: String
    
    /// The unique identifier of the merchant in the Juspay system.
    public let merchantId: String
    
    /// The currency code for the order amount (e.g., "INR", "USD").
    public let currency: String
    
    /// The URL to which the customer will be redirected after payment completion.
    /// This property is optional and may be `nil`.
    public let returnUrl: String?
    
    /// The identifier of the product associated with this order, if applicable.
    /// This property is optional and may be `nil`.
    public let productId: String?
    
    /// The transaction identifier associated with this order, if available.
    /// This property is optional and may be `nil`.
    public let txnId: String?
    
    /// The type of payment method used for this order (e.g., "CARD", "UPI").
    /// This property is optional and may be `nil`.
    public let paymentMethodType: String?
    
    /// The specific payment method used for this order (e.g., "VISA", "GPAY").
    /// This property is optional and may be `nil`.
    public let paymentMethod: String?
    
    /// The type of authentication used for the payment (e.g., "3DS", "OTP").
    /// This property is optional and may be `nil`.
    public let authType: String?
    
    /// A boolean indicating whether the order has been refunded.
    public let refunded: Bool
    
    /// The total amount that has been refunded for this order.
    public let amountRefunded: Double
    
    /// Links to different payment interfaces for this order.
    /// This property is optional and may be `nil`.
    public let paymentLinks: PaymentLinks?
    
    /// An array of refund objects associated with this order, if any.
    /// This property is optional and may be `nil`.
    public let refunds: [Refund]?
    
    /// A unique identifier for the transaction, different from `txnId`.
    /// This property is optional and may be `nil`.
    public let txnUuid: String?
    
    /// Detailed information about the transaction associated with this order.
    /// This property is optional and may be `nil`.
    public let txnDetail: TransactionDetail?
    
    /// The identifier of the payment gateway used for this order.
    /// This property is optional and may be `nil`.
    public let gatewayId: Int?
    
    /// The reference identifier provided by the payment gateway for this order.
    /// This property is optional and may be `nil`.
    public let gatewayReferenceId: String?
    
    /// Information about the card used for payment, if applicable.
    /// This property is optional and may be `nil`.
    public let card: CardInfo?
}

/// A structure representing the response received when creating a new order.
public struct OrderCreationResponse: Codable, Sendable {
    /// The status of the order creation request (e.g., "CREATED").
    public let status: String
    
    /// The numeric representation of the order creation status.
    public let statusId: Int
    
    /// The unique identifier for the newly created order in the Juspay system.
    public let id: String
    
    /// The order identifier provided by the merchant for the newly created order.
    public let orderId: String
    
    /// Links to different payment interfaces for the newly created order.
    public let paymentLinks: PaymentLinks
    
    /// Additional Juspay-specific information for the newly created order.
    public let juspay: JuspayInfo
}

/// A structure containing links to different payment interfaces.
public struct PaymentLinks: Codable, Sendable {
    /// The URL for the web-based payment interface.
    public let web: String
    
    /// The URL for the mobile-based payment interface.
    public let mobile: String
    
    /// The URL for the iframe-based payment interface.
    public let iframe: String
}

/// A structure representing a refund associated with an order.
public struct Refund: Codable, Sendable {
    /// A unique identifier for the refund request.
    public let uniqueRequestId: String
    
    /// The current status of the refund (e.g., "COMPLETED", "PENDING").
    public let status: String
    
    /// A boolean indicating whether the refund request has been sent to the payment gateway.
    public let sentToGateway: Bool
    
    /// The type of refund (e.g., "FULL", "PARTIAL").
    public let refundType: String
    
    /// The source of the refund initiation (e.g., "MERCHANT", "CUSTOMER").
    /// This property is optional and may be `nil`.
    public let refundSource: String?
    
    /// A reference identifier for the refund, if applicable.
    /// This property is optional and may be `nil`.
    public let ref: String?
    
    /// Information about who initiated the refund.
    /// This property is optional and may be `nil`.
    public let initiatedBy: String?
    
    /// The unique identifier for the refund in the Juspay system.
    public let id: String
    
    /// The amount that was refunded.
    public let amount: Double
    
    /// The date and time when the refund was created.
    public let created: Date
    
    /// An error message, if the refund encountered any issues.
    /// This property is optional and may be `nil`.
    public let errorMessage: String?
    
    /// An error code, if the refund encountered any issues.
    /// This property is optional and may be `nil`.
    public let errorCode: String?
}

/// A structure containing detailed information about a transaction.
public struct TransactionDetail: Codable, Sendable {
    /// The transaction identifier.
    public let txnId: String
    
    /// The order identifier associated with this transaction.
    public let orderId: String
    
    /// The current status of the transaction.
    public let status: String
    
    /// An error code, if the transaction encountered any issues.
    /// This property is optional and may be `nil`.
    public let errorCode: String?
    
    /// The currency code for the transaction amount.
    public let currency: String
    
    /// A unique identifier for the transaction, different from `txnId`.
    public let txnUuid: String
    
    /// The name of the payment gateway used for this transaction.
    public let gateway: String
    
    /// An error message, if the transaction encountered any issues.
    /// This property is optional and may be `nil`.
    public let errorMessage: String?
}

/// A structure containing information about the card used for payment.
public struct CardInfo: Codable, Sendable {
    /// The expiry year of the card.
    /// This property is optional and may be `nil`.
    public let expiryYear: String?
    
    /// A reference identifier for the card in the payment system.
    /// This property is optional and may be `nil`.
    public let cardReference: String?
    
    /// The expiry month of the card.
    /// This property is optional and may be `nil`.
    public let expiryMonth: String?
    
    /// A boolean indicating whether the card details were saved for future use.
    public let savedToLocker: Bool
    
    /// The name of the cardholder as it appears on the card.
    /// This property is optional and may be `nil`.
    public let nameOnCard: String?
    
    /// The name of the bank or institution that issued the card.
    /// This property is optional and may be `nil`.
    public let cardIssuer: String?
    
    /// The last four digits of the card number.
    /// This property is optional and may be `nil`.
    public let lastFourDigits: String?
    
    /// A boolean indicating whether this payment used a previously saved card.
    public let usingSavedCard: Bool
    
    /// A unique identifier for the card, typically used for fraud detection.
    /// This property is optional and may be `nil`.
    public let cardFingerprint: String?
    
    /// The International Securities Identification Number (ISIN) for the card, if applicable.
    /// This property is optional and may be `nil`.
    public let cardIsin: String?
    
    /// The type of the card (e.g., "CREDIT", "DEBIT").
    /// This property is optional and may be `nil`.
    public let cardType: String?
    
    /// The brand of the card (e.g., "VISA", "MASTERCARD").
    /// This property is optional and may be `nil`.
    public let cardBrand: String?
}

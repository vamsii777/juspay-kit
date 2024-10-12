import Foundation

public struct Order: Codable {
    public let id: String
    public let orderId: String
    public let status: String
    public let statusId: Int
    public let amount: Double
    public let dateCreated: Date
    public let customerEmail: String
    public let customerPhone: String
    public let customerId: String
    public let merchantId: String
    public let currency: String
    public let returnUrl: String?
    public let productId: String?
    public let txnId: String?
    public let paymentMethodType: String?
    public let paymentMethod: String?
    public let authType: String?
    public let refunded: Bool
    public let amountRefunded: Double
    public let paymentLinks: PaymentLinks?
    public let refunds: [Refund]?
    public let txnUuid: String?
    public let txnDetail: TransactionDetail?
    public let gatewayId: Int?
    public let gatewayReferenceId: String?
    public let card: CardInfo?
}

public struct OrderCreationResponse: Codable {
    public let status: String
    public let statusId: Int
    public let id: String
    public let orderId: String
    public let paymentLinks: PaymentLinks
    public let juspay: JuspayInfo
}

public struct PaymentLinks: Codable {
    public let web: String
    public let mobile: String
    public let iframe: String
}

public struct Refund: Codable {
    public let uniqueRequestId: String
    public let status: String
    public let sentToGateway: Bool
    public let refundType: String
    public let refundSource: String?
    public let ref: String?
    public let initiatedBy: String?
    public let id: String
    public let amount: Double
    public let created: Date
    public let errorMessage: String?
    public let errorCode: String?
}

public struct TransactionDetail: Codable {
    public let txnId: String
    public let orderId: String
    public let status: String
    public let errorCode: String?
    public let currency: String
    public let txnUuid: String
    public let gateway: String
    public let errorMessage: String?
}

public struct CardInfo: Codable {
    public let expiryYear: String?
    public let cardReference: String?
    public let expiryMonth: String?
    public let savedToLocker: Bool
    public let nameOnCard: String?
    public let cardIssuer: String?
    public let lastFourDigits: String?
    public let usingSavedCard: Bool
    public let cardFingerprint: String?
    public let cardIsin: String?
    public let cardType: String?
    public let cardBrand: String?
}

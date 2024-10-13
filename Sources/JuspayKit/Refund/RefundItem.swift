import Foundation

/// A structure representing a refund request in the Juspay system.
///
/// This struct encapsulates the necessary information to initiate a refund for a transaction.
public struct RefundRequest: Codable, Sendable {
    /// A unique identifier for the refund request.
    ///
    /// This identifier helps in tracking and referencing the specific refund request.
    public let uniqueRequestId: String
    
    /// The amount to be refunded.
    ///
    /// This value should be a positive number representing the refund amount in the original transaction's currency.
    public let amount: Double
    
    private enum CodingKeys: String, CodingKey {
        case uniqueRequestId = "unique_request_id"
        case amount
    }
}

/// A structure representing the response to a refund request in the Juspay system.
///
/// This struct contains detailed information about the refund operation, including its status and associated details.
public struct RefundResponse: Codable, Sendable {
    public let status: String?
    public let id: String?
    public let orderId: String?
    public let refunds: [RefundDetail]?
    public let txnUuid: String?
    public let txnId: String?
    public let txnDetail: TransactionDetail?
    public let returnUrl: String?
    public let refunded: Bool?
    public let paymentLinks: PaymentLinks?
    public let paymentGatewayResponse: PaymentGatewayResponse?
    public let metadata: [String: String]?
    public let effectiveAmount: Int?
    public let dateCreated: String?
    public let customerPhone: String?
    public let customerId: String?
    public let customerEmail: String?
    public let currency: String?
    public let card: CardDetails?
    public let amountRefunded: Int?
    public let amount: Int?
    public let maximumEligibleRefundAmount: Int?
    public let udf1: String?
    public let udf2: String?
    public let udf3: String?
    public let udf4: String?
    public let udf5: String?
    public let udf6: String?
    public let udf7: String?
    public let udf8: String?
    public let udf9: String?
    public let udf10: String?
    public let rewardsBreakup: String?
    public let productId: String?
    public let paymentMethodType: String?
    public let paymentMethod: String?
    public let offers: [String]?
    public let merchantId: String?
    public let gatewayReferenceId: String?
    public let gatewayId: Int?
    public let bankPg: String?
    public let bankErrorMessage: String?
    public let bankErrorCode: String?
    
    public struct TransactionDetail: Codable, Sendable {
        public let txnUuid: String?
        public let txnId: String?
        public let txnAmount: Int?
        public let taxAmount: Int
        public let surchargeAmount: Int
        public let status: String?
        public let redirect: Bool?
        public let orderId: String?
        public let netAmount: Int?
        public let gatewayId: Int?
        public let gateway: String?
        public let expressCheckout: Bool?
        public let errorMessage: String?
        public let errorCode: String?
        public let currency: String?
        public let created: String?
        public let statusId: Int?
    }
    
    public struct PaymentGatewayResponse: Codable, Sendable {
        public let txnId: String?
        public let rrn: String?
        public let respMessage: String?
        public let respCode: String?
        public let epgTxnId: String?
        public let created: String?
        public let authIdCode: String?
    }
    
    public struct CardDetails: Codable, Sendable {
        public let usingToken: Bool?
        public let usingSavedCard: Bool?
        public let savedToLocker: Bool?
        public let nameOnCard: String?
        public let lastFourDigits: String?
        public let expiryYear: String?
        public let expiryMonth: String?
        public let cardType: String?
        public let cardReference: String?
        public let cardIssuer: String?
        public let cardIsin: String?
        public let cardFingerprint: String?
        public let cardBrand: String?
        public let authType: String?
    }
}

public struct RefundDetail: Codable, Sendable {
    public let uniqueRequestId: String?
    public let status: String?
    public let sentToGateway: Bool?
    public let refundType: String?
    public let refundSource: String?
    public let ref: String?
    public let initiatedBy: String?
    public let id: String?
    public let errorMessage: String?
    public let errorCode: String?
    public let created: String?
    public let amount: Int?
}

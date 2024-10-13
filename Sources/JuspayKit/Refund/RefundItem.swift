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
    public let status: String
    public let id: String
    public let orderId: String
    public let refunds: [RefundDetail]?
    public let txnUuid: String
    public let txnId: String
    public let txnDetail: TransactionDetail
    public let returnUrl: String?
    public let refunded: Bool
    public let paymentLinks: PaymentLinks?
    public let paymentGatewayResponse: PaymentGatewayResponse?
    public let metadata: [String: String]?
    public let effectiveAmount: Int
    public let dateCreated: String
    public let customerPhone: String
    public let customerId: String
    public let customerEmail: String
    public let currency: String
    public let card: CardDetails?
    public let amountRefunded: Int
    public let amount: Int
    public let maximumEligibleRefundAmount: Int
    
    public struct TransactionDetail: Codable, Sendable {
        public let txnUuid: String
        public let txnId: String
        public let txnAmount: Int
        public let status: String
        public let redirect: Bool
        public let orderId: String
        public let netAmount: Int
        public let gatewayId: Int
        public let gateway: String
        public let expressCheckout: Bool
        public let errorMessage: String?
        public let errorCode: String?
        public let currency: String
        public let created: String
        public let statusId: Int
        
        private enum CodingKeys: String, CodingKey {
            case txnUuid = "txn_uuid"
            case txnId = "txn_id"
            case txnAmount = "txn_amount"
            case status, redirect
            case orderId = "order_id"
            case netAmount = "net_amount"
            case gatewayId = "gateway_id"
            case gateway
            case expressCheckout = "express_checkout"
            case errorMessage = "error_message"
            case errorCode = "error_code"
            case currency, created
            case statusId = "status_id"
        }
    }
    
    public struct PaymentGatewayResponse: Codable, Sendable {
        public let txnId: String
        public let rrn: String
        public let respMessage: String
        public let respCode: String
        public let epgTxnId: String
        public let created: String
        public let authIdCode: String
        
        private enum CodingKeys: String, CodingKey {
            case txnId = "txn_id"
            case rrn
            case respMessage = "resp_message"
            case respCode = "resp_code"
            case epgTxnId = "epg_txn_id"
            case created
            case authIdCode = "auth_id_code"
        }
    }
    
    public struct CardDetails: Codable, Sendable {
        public let usingToken: Bool
        public let usingSavedCard: Bool
        public let savedToLocker: Bool
        public let nameOnCard: String
        public let lastFourDigits: String
        public let expiryYear: String
        public let expiryMonth: String
        public let cardType: String
        public let cardReference: String
        public let cardIssuer: String
        public let cardIsin: String
        public let cardFingerprint: String
        public let cardBrand: String
        public let authType: String
        
        private enum CodingKeys: String, CodingKey {
            case usingToken = "using_token"
            case usingSavedCard = "using_saved_card"
            case savedToLocker = "saved_to_locker"
            case nameOnCard = "name_on_card"
            case lastFourDigits = "last_four_digits"
            case expiryYear = "expiry_year"
            case expiryMonth = "expiry_month"
            case cardType = "card_type"
            case cardReference = "card_reference"
            case cardIssuer = "card_issuer"
            case cardIsin = "card_isin"
            case cardFingerprint = "card_fingerprint"
            case cardBrand = "card_brand"
            case authType = "auth_type"
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case status, id
        case orderId = "order_id"
        case txnUuid = "txn_uuid"
        case txnId = "txn_id"
        case txnDetail = "txn_detail"
        case refunds
        case returnUrl = "return_url"
        case refunded
        case paymentLinks = "payment_links"
        case paymentGatewayResponse = "payment_gateway_response"
        case metadata
        case effectiveAmount = "effective_amount"
        case dateCreated = "date_created"
        case customerPhone = "customer_phone"
        case customerId = "customer_id"
        case customerEmail = "customer_email"
        case currency, card
        case amountRefunded = "amount_refunded"
        case amount
        case maximumEligibleRefundAmount = "maximum_eligible_refund_amount"
    }
}

public struct RefundDetail: Codable, Sendable {
    public let uniqueRequestId: String
    public let status: String
    public let sentToGateway: Bool
    public let refundType: String
    public let refundSource: String
    public let ref: String?
    public let initiatedBy: String
    public let id: String?
    public let errorMessage: String?
    public let errorCode: String?
    public let created: String
    public let amount: Double
}

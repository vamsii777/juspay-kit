import Foundation

public struct RefundRequest: Codable {
    public let uniqueRequestId: String
    public let amount: Double
}

public struct RefundResponse: Codable {
    public let status: String
    public let id: String
    public let orderId: String
    public let refunds: [RefundDetail]?

    public struct RefundDetail: Codable {
        public let uniqueRequestId: String
        public let status: String
        public let sentToGateway: Bool
        public let refundType: String
        public let refundSource: String
        public let ref: String?
        public let initiatedBy: String
        public let id: String
        public let errorMessage: String?
        public let errorCode: String?
        public let created: String
        public let amount: Double
    }
}

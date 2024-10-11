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
}

/// A structure representing the response to a refund request in the Juspay system.
///
/// This struct contains detailed information about the refund operation, including its status and associated details.
public struct RefundResponse: Codable, Sendable {
    /// The current status of the refund operation.
    ///
    /// Possible values may include "INITIATED", "PROCESSING", "COMPLETED", or "FAILED".
    public let status: String

    /// The unique identifier for this refund operation in the Juspay system.
    public let id: String

    /// The identifier of the original order for which the refund was requested.
    public let orderId: String

    /// An optional array of detailed refund information.
    ///
    /// This property may be `nil` if no detailed information is available.
    public let refunds: [RefundDetail]?

    /// A structure representing detailed information about a specific refund.
    public struct RefundDetail: Codable, Sendable {
        /// The unique identifier for this specific refund request.
        public let uniqueRequestId: String

        /// The current status of this specific refund.
        public let status: String

        /// A boolean indicating whether the refund request has been sent to the payment gateway.
        public let sentToGateway: Bool

        /// The type of refund (e.g., "FULL", "PARTIAL").
        public let refundType: String

        /// The source of the refund initiation (e.g., "MERCHANT", "CUSTOMER").
        public let refundSource: String

        /// An optional reference string for the refund.
        ///
        /// This property may be `nil` if no reference is provided.
        public let ref: String?

        /// The entity or system that initiated the refund.
        public let initiatedBy: String

        /// The unique identifier for this refund in the Juspay system.
        public let id: String

        /// An optional error message if the refund encountered an issue.
        ///
        /// This property will be `nil` if no error occurred.
        public let errorMessage: String?

        /// An optional error code if the refund encountered an issue.
        ///
        /// This property will be `nil` if no error occurred.
        public let errorCode: String?

        /// The date and time when the refund was created, represented as a string.
        ///
        /// The format of this string may vary based on the Juspay API's configuration.
        public let created: String

        /// The amount that was refunded.
        public let amount: Double
    }
}

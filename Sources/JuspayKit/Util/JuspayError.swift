import Foundation

/// Represents errors that can occur during interactions with the Juspay payment gateway.
///
/// This enumeration conforms to both `Error` and `Codable` protocols, allowing it to be used
/// for error handling and serialization/deserialization in network communications.
///
/// - Note: The `Codable` conformance uses a custom implementation to handle the various error types.
public enum JuspayError: Error, Codable {
    /// Indicates that the input provided to an operation was invalid.
    /// - Parameter message: A description of why the input was considered invalid.
    case invalidInput(message: String)

    /// Indicates that authentication with the Juspay API failed.
    case authenticationFailed

    /// Represents a server-side error reported by the Juspay API.
    /// - Parameter message: A description of the server error.
    case serverError(message: String)

    /// Indicates that an attempt to create an order failed.
    /// - Parameter message: A description of why the order creation failed.
    case orderCreationFailed(message: String)

    /// Indicates that an attempt to create a refund failed.
    /// - Parameter message: A description of why the refund creation failed.
    case refundCreationFailed(message: String)

    /// Indicates that the response from the API was invalid or unexpected.
    case invalidResponse

    // MARK: - Codable Implementation

    private enum CodingKeys: String, CodingKey {
        case type, message
    }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer is part of the `Decodable` protocol implementation. It decodes the error type
    /// and associated message (if any) from the provided decoder.
    ///
    /// - Parameter decoder: The decoder to read data from.
    /// - Throws: `DecodingError.dataCorrupted` if an unknown error type is encountered.
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case "invalid_input":
            let message = try container.decode(String.self, forKey: .message)
            self = .invalidInput(message: message)
        case "authentication_failed":
            self = .authenticationFailed
        case "server_error":
            let message = try container.decode(String.self, forKey: .message)
            self = .serverError(message: message)
        case "order_creation_failed":
            let message = try container.decode(String.self, forKey: .message)
            self = .orderCreationFailed(message: message)
        case "refund_creation_failed":
            let message = try container.decode(String.self, forKey: .message)
            self = .refundCreationFailed(message: message)
        default:
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Unknown error type"))
        }
    }

    /// Encodes this value into the given encoder.
    ///
    /// This function is part of the `Encodable` protocol implementation. It encodes the error type
    /// and associated message (if any) into the provided encoder.
    ///
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: Any error that occurs during encoding.
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case let .invalidInput(message):
            try container.encode("invalid_input", forKey: .type)
            try container.encode(message, forKey: .message)
        case .authenticationFailed:
            try container.encode("authentication_failed", forKey: .type)
        case let .serverError(message):
            try container.encode("server_error", forKey: .type)
            try container.encode(message, forKey: .message)
        case let .orderCreationFailed(message):
            try container.encode("order_creation_failed", forKey: .type)
            try container.encode(message, forKey: .message)
        case let .refundCreationFailed(message):
            try container.encode("refund_creation_failed", forKey: .type)
            try container.encode(message, forKey: .message)
        case .invalidResponse:
            try container.encode("invalid_response", forKey: .type)
        }
    }
}

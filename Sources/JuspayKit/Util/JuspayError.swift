import Foundation

public enum JuspayError: Error, Codable {
    case invalidInput(message: String)
    case authenticationFailed
    case serverError(message: String)
    case orderCreationFailed(message: String)
    case refundCreationFailed(message: String)

    private enum CodingKeys: String, CodingKey {
        case type, message
    }

    public init(from decoder: Decoder) throws {
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .invalidInput(let message):
            try container.encode("invalid_input", forKey: .type)
            try container.encode(message, forKey: .message)
        case .authenticationFailed:
            try container.encode("authentication_failed", forKey: .type)
        case .serverError(let message):
            try container.encode("server_error", forKey: .type)
            try container.encode(message, forKey: .message)
        case .orderCreationFailed(let message):
            try container.encode("order_creation_failed", forKey: .type)
            try container.encode(message, forKey: .message)
        case .refundCreationFailed(let message):
            try container.encode("refund_creation_failed", forKey: .type)
            try container.encode(message, forKey: .message)
        }
    }
}

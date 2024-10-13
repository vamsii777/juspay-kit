import Foundation

public enum ErrorCode: Error, Codable, Sendable, Equatable {
    case duplicateCall
    case invalidAmountExceeded
    case mandatoryFieldsMissing
    case invalidAmount
    case invalidOrderNotSuccessful
    case requestExceeded
    case accessDenied
    case badRequest
    case unknown(String)
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        
        switch rawValue {
        case "duplicate.call":
            self = .duplicateCall
        case "invalid.amount.exceeded":
            self = .invalidAmountExceeded
        case "Mandatory fields are missing":
            self = .mandatoryFieldsMissing
        case "invalid amount":
            self = .invalidAmount
        case "invalid.order.not_successful":
            self = .invalidOrderNotSuccessful
        case "request.exceeded":
            self = .requestExceeded
        case "access_denied":
            self = .accessDenied
        case "Bad request.":
            self = .badRequest
        default:
            self = .unknown(rawValue)
        }
    }
    
    public init(rawValue: String) {
        switch rawValue {
        case "duplicate.call":
            self = .duplicateCall
        case "invalid.amount.exceeded":
            self = .invalidAmountExceeded
        case "Mandatory fields are missing":
            self = .mandatoryFieldsMissing
        case "invalid amount":
            self = .invalidAmount
        case "invalid.order.not_successful":
            self = .invalidOrderNotSuccessful
        case "request.exceeded":
            self = .requestExceeded
        case "access_denied":
            self = .accessDenied
        case "Bad request.":
            self = .badRequest
        default:
            self = .unknown(rawValue)
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .duplicateCall:
            try container.encode("duplicate.call")
        case .invalidAmountExceeded:
            try container.encode("invalid.amount.exceeded")
        case .mandatoryFieldsMissing:
            try container.encode("Mandatory fields are missing")
        case .invalidAmount:
            try container.encode("invalid amount")
        case .invalidOrderNotSuccessful:
            try container.encode("invalid.order.not_successful")
        case .requestExceeded:
            try container.encode("request.exceeded")
        case .accessDenied:
            try container.encode("access_denied")
        case .badRequest:
            try container.encode("Bad request.")
        case .unknown(let rawValue):
            try container.encode(rawValue)
        }
    }
}

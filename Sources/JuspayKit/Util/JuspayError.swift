import Foundation

struct JuspayError: Error, Codable, Sendable, LocalizedError {
    let status: String
    let errorCode: String?
    let errorMessage: String?
    let statusID: Int?
    let errorInfo: ErrorInfo?

    struct ErrorInfo: Codable {
        let category: String
        let requestID: String
        let href: String
        let developerMessage: String
        let userMessage: String
        let code: String
        let fields: [Field]?

        struct Field: Codable {
            let fieldName: String
            let reason: String

            enum CodingKeys: String, CodingKey {
                case fieldName = "field_name"
                case reason
            }
        }

        enum CodingKeys: String, CodingKey {
            case category
            case requestID = "request_id"
            case href
            case developerMessage = "developer_message"
            case userMessage = "user_message"
            case code
            case fields
        }
    }

    enum CodingKeys: String, CodingKey {
        case status
        case errorCode = "error_code"
        case errorMessage = "error_message"
        case statusID = "status_id"
        case errorInfo = "error_info"
    }
    
    var parsedErrorCode: ErrorCode {
        ErrorCode(rawValue: errorCode ?? "") ?? .unknown(errorCode ?? "")   
    }
}

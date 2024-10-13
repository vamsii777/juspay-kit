import Foundation

public struct JuspayError: Error, Codable, Sendable {
    /// The type of error returned.
    public var type: String?
    /// A short string indicating the error code reported.
    public var errorCode: String?
    /// A human-readable message providing more details about the error.
    public var errorMessage: String
    /// The status ID of the error.
    public var statusId: Int
    /// Additional information about the error.
    public var errorInfo: ErrorInfo
    
    public var localizedDescription: String {
        return errorMessage
    }
}

extension JuspayError: LocalizedError {
    public var errorDescription: String? {
        return errorMessage
    }
}

public struct ErrorInfo: Codable, Sendable {
    /// The category of the error.
    public var category: String
    /// The request ID associated with the error.
    public var requestId: String
    /// A URL to more information about the error.
    public var href: String
    /// A message for developers about the error.
    public var developerMessage: String
    /// A message for users about the error.
    public var userMessage: String
    /// A code associated with the error.
    public var code: String
}

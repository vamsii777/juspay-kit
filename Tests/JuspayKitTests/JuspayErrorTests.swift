import XCTest
@testable import JuspayKit

final class JuspayErrorTests: XCTestCase {
    
    func testJuspayErrorDecoding() throws {
        let jsonString = """
        {
            "status": "ERROR",
            "error_code": "invalid.amount.exceeded",
            "error_message": "Refund amount exceeds the refundable amount.",
            "status_id": -1,
            "error_info": {
                "category": "USER_ERROR",
                "request_id": "b9b58b8e-58bd-4628-9f20-8c84bef5c53c",
                "href": "NA",
                "developer_message": "Refund amount exceeds the refundable amount.",
                "user_message": "Invalid request params. Please verify your input.",
                "code": "INVALID_INPUT"
            }
        }
        """
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("Failed to convert JSON string to Data")
            return
        }
        do {
            let decoder = JSONDecoder()
            let error = try decoder.decode(JuspayError.self, from: jsonData)
            
            XCTAssertEqual(error.status, "ERROR")
            XCTAssertEqual(error.errorCode, "invalid.amount.exceeded")
            XCTAssertEqual(error.errorMessage, "Refund amount exceeds the refundable amount.")
            XCTAssertEqual(error.statusID, -1)
            
            XCTAssertNotNil(error.errorInfo)
            XCTAssertEqual(error.errorInfo?.category, "USER_ERROR")
            XCTAssertEqual(error.errorInfo?.requestID, "b9b58b8e-58bd-4628-9f20-8c84bef5c53c")
            XCTAssertEqual(error.errorInfo?.href, "NA")
            XCTAssertEqual(error.errorInfo?.developerMessage, "Refund amount exceeds the refundable amount.")
            XCTAssertEqual(error.errorInfo?.userMessage, "Invalid request params. Please verify your input.")
            XCTAssertEqual(error.errorInfo?.code, "INVALID_INPUT")
            XCTAssertEqual(error.parsedErrorCode, .invalidAmountExceeded)
        } catch {
            XCTFail("Failed to decode JuspayError: \(error)")
        }
    }
    
    func testJuspayErrorEncodingDecoding() throws {
        let originalError = JuspayError(
            status: "ERROR",
            errorCode: "invalid.amount.exceeded",
            errorMessage: "Test message",
            statusID: 123,
            errorInfo: JuspayError.ErrorInfo(
                category: "TEST",
                requestID: "test-id",
                href: "test-href",
                developerMessage: "Dev message",
                userMessage: "User message",
                code: "TEST_CODE",
                fields: nil
            )
        )
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        do {
            let encodedData = try encoder.encode(originalError)
            let decodedError = try decoder.decode(JuspayError.self, from: encodedData)
            XCTAssertEqual(originalError.status, decodedError.status)
            XCTAssertEqual(originalError.errorCode, decodedError.errorCode)
            XCTAssertEqual(originalError.errorMessage, decodedError.errorMessage)
            XCTAssertEqual(originalError.statusID, decodedError.statusID)
            XCTAssertEqual(originalError.errorInfo?.category, decodedError.errorInfo?.category)
            XCTAssertEqual(originalError.errorInfo?.requestID, decodedError.errorInfo?.requestID)
            XCTAssertEqual(originalError.errorInfo?.href, decodedError.errorInfo?.href)
            XCTAssertEqual(originalError.errorInfo?.developerMessage, decodedError.errorInfo?.developerMessage)
            XCTAssertEqual(originalError.errorInfo?.userMessage, decodedError.errorInfo?.userMessage)
            XCTAssertEqual(originalError.errorInfo?.code, decodedError.errorInfo?.code)
        } catch {
            XCTFail("Failed to encode or decode JuspayError: \(error)")
        }
    }
}

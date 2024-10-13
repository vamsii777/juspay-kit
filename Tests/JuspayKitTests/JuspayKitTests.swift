@testable import JuspayKit
import XCTest
import NIO
import AsyncHTTPClient

final class JuspayKitTests: XCTestCase {
    var juspayClient: JuspayClient!
    var httpClient: HTTPClient!
    var merchantId: String!

    override func setUpWithError() throws {
        httpClient = HTTPClient(eventLoopGroupProvider: .singleton)
        guard let apiKey = ProcessInfo.processInfo.environment["JUSPAY_API_KEY"] else {
            XCTFail("JUSPAY_API_KEY not found")
            throw TestError.environmentVariableNotFound("JUSPAY_API_KEY")
        }
        guard let merchantId = ProcessInfo.processInfo.environment["JUSPAY_MERCHANT_ID"] else { 
            XCTFail("JUSPAY_MERCHANT_ID not found")
            throw TestError.environmentVariableNotFound("JUSPAY_MERCHANT_ID")
        }
        self.merchantId = merchantId
        juspayClient = JuspayClient(httpClient: httpClient, apiKey: apiKey, merchantId: merchantId, environment: .production)
    }

    override func tearDownWithError() throws {
        try httpClient.syncShutdown()
        juspayClient = nil
        httpClient = nil
        merchantId = nil
    }

    func testCreateSession() async throws {
        guard let orderId = Order.generateOrderID() else {
            XCTFail("Failed to generate order ID")
            throw TestError.orderIDGenerationFailed
        }
        let sessionData = Session(
            orderId: orderId, 
            amount: "1.0", 
            customerId: "4C2AD8F11484CE", 
            customerEmail: "vamsi@dewonderstruck.com", 
            customerPhone: "7989378465", 
            paymentPageClientId: merchantId,
            action: .paymentPage,
            returnUrl: "https://shop.merchant.com"
        )
        do {
            let session = try await juspayClient.sessions.create(session: sessionData)
            XCTAssertNotNil(session)
        } catch {
            XCTFail("Session creation failed with error: \(error)")
            throw error
        }   
    } 

    func testRetrieveOrder() async throws {
        do {
            let order = try await juspayClient.orders.retrieve(orderId: "V5Q2kPjsMlGVgr9kcq29")
            XCTAssertNotNil(order)
        } catch let error as JuspayError {
            print("Error: \(error.localizedDescription)") 
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testRefundOrder() async throws {
        let uniqueRequestID = RefundRequest.generateUniqueRequestID()
        let refundData = RefundRequest(
            uniqueRequestId: uniqueRequestID,
            amount: 1.0
        )
        do {
            let refund = try await juspayClient.refunds.create(orderId: "V5Q2kPjsMlGVgr9kcq29", refund: refundData)
            XCTAssertNotNil(refund)
        } catch let error as JuspayError {
            print("Error: \(error)") 
        } catch {
            XCTFail("Unexpected error: \(error.localizedDescription)")
        }
    }

    func testHealthCheck() async throws {
        do {
            let health = try await juspayClient.health.check()
            XCTAssertNotNil(health)
        } catch {
            XCTFail("Health check failed with error: \(error)")
            throw error
        }
    }   
}

enum TestError: Error {
    case environmentVariableNotFound(String)
    case orderIDGenerationFailed
}

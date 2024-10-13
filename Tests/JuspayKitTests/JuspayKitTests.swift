@testable import JuspayKit
import XCTest
import NIO
import AsyncHTTPClient

final class JuspayKitTests: XCTestCase {
    var juspayClient: JuspayClient!
    var httpClient: HTTPClient!
    var merchantId: String!
    var orderId: String!

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
        
        guard let generatedOrderId = Order.generateOrderID() else {
            XCTFail("Failed to generate order ID")
            throw TestError.orderIDGenerationFailed
        }
        self.orderId = generatedOrderId
    }

    override func tearDownWithError() throws {
        try httpClient.syncShutdown()
        juspayClient = nil
        httpClient = nil
        merchantId = nil
        orderId = nil
    }

    func testCreateSession() async throws {
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
        let session = try await juspayClient.sessions.create(session: sessionData)
        XCTAssertNotNil(session)
    } 

    func testRetrieveOrder() async throws {
        let order = try await juspayClient.orders.retrieve(orderId: "OiVWluhiNXAQtR10BQaK")
        XCTAssertNotNil(order)
    }

    func testRefundOrder() async throws {
        let uniqueRequestID = RefundRequest.generateUniqueRequestID()
        let refundData = RefundRequest(
            uniqueRequestId: uniqueRequestID,
            amount: 1.0
        )
        let refund = try await juspayClient.refunds.create(orderId: "9K7pKhlGE5o6hSJ0fJw6", refund: refundData)
        XCTAssertNotNil(refund)
    }

    func testHealthCheck() async throws {
        let health = try await juspayClient.health.check()
        XCTAssertNotNil(health)
    }   
}

enum TestError: Error {
    case environmentVariableNotFound(String)
    case orderIDGenerationFailed
}

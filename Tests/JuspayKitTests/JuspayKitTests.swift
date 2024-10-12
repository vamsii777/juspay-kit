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

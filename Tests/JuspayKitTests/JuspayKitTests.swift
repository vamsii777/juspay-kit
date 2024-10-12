@testable import JuspayKit
import XCTest
import NIO
import AsyncHTTPClient

final class JuspayKitTests: XCTestCase {
    var juspayClient: JuspayClient!
    var httpClient: HTTPClient!

    override func setUp() {
        httpClient = HTTPClient(eventLoopGroupProvider: .singleton)
        juspayClient = JuspayClient(httpClient: httpClient, apiKey: "apikey_1234567890", merchantId: "merchant_1234567890", environment: .production)
    }

    func testCreateSession() async throws {
        guard let orderId = Order.generateOrderID() else {
            XCTFail("Failed to generate order ID")
            return
        }
        let data = Session(
            orderId: orderId, 
            amount: "1.0", 
            customerId: "testing-customer-one", 
            customerEmail: "test@mail.com", 
            customerPhone: "9000000000", 
            paymentPageClientId: "client_id_1234567890",
            action: .paymentPage,
            returnUrl: "https://shop.merchant.com"
        )
        let session = try await juspayClient.sessions.create(session: data)
        print(session)
        XCTAssertNotNil(session)
    }   

    func testHealthCheck() async throws {
        let health = try await juspayClient.health.check()
        print(health)
        XCTAssertNotNil(health)
    }   
}

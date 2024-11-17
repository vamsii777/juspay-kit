import Testing
import AsyncHTTPClient
@testable import JuspayKit
import NIO
import Foundation

@Suite
struct JuspayKitTests {
    let juspayClient: JuspayClient
    let merchantId: String
    let orderId: String
    
    init() throws {
        
        guard let apiKey = ProcessInfo.processInfo.environment["JUSPAY_API_KEY"] else {
            Issue.record("JUSPAY_API_KEY not found")
            throw TestError.environmentVariableNotFound("JUSPAY_API_KEY")
        }
        
        guard let merchantId = ProcessInfo.processInfo.environment["JUSPAY_MERCHANT_ID"] else {
            Issue.record("JUSPAY_MERCHANT_ID not found")
            throw TestError.environmentVariableNotFound("JUSPAY_MERCHANT_ID")
        }
        
        self.merchantId = merchantId
        self.juspayClient = JuspayClient(httpClient: HTTPClient.shared, apiKey: apiKey, merchantId: merchantId, environment: .production)
        
        guard let generatedOrderId = Order.generateOrderID() else {
            Issue.record("Failed to generate order ID")
            throw TestError.orderIDGenerationFailed
        }
        self.orderId = generatedOrderId
    }

    @Test("Create a new session")
    func createSession() async throws {
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
        #expect(session != nil)
    }

    @Test("Retrieve an order")
    func retrieveOrder() async throws {
        let order = try await juspayClient.orders.retrieve(orderId: "OiVWluhiNXAQtR10BQaK")
        #expect(order != nil)
    }

    @Test("Refund an order")
    func refundOrder() async throws {
        let uniqueRequestID = RefundRequest.generateUniqueRequestID()
        let refundData = RefundRequest(
            uniqueRequestId: uniqueRequestID,
            amount: 1.0
        )
        let refund = try await juspayClient.refunds.create(orderId: "9K7pKhlGE5o6hSJ0fJw6", refund: refundData)
        #expect(refund != nil)
    }

    @Test("Check API health")
    func healthCheck() async throws {
        let health = try await juspayClient.health.check()
        #expect(health != nil)
    }
}

enum TestError: Error {
    case environmentVariableNotFound(String)
    case orderIDGenerationFailed
}

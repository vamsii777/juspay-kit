import Testing
import AsyncHTTPClient
@testable import HyperCheckout
@testable import JuspayKit
import NIO
import Foundation

@Suite
struct HyperCheckoutTests {
    let hyperCheckout: HyperCheckoutClient
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
        
        // Initialize the base Juspay client
        let juspayClient = JuspayClient(
            httpClient: HTTPClient.shared,
            apiKey: apiKey,
            merchantId: merchantId,
            environment: .sandbox
        )
        
        // Create the HyperCheckout client
        self.hyperCheckout = HyperCheckoutClient(juspayClient)
        
        // Generate a unique order ID for testing
        guard let generatedOrderId = Order.generateOrderID() else {
            Issue.record("Failed to generate order ID")
            throw TestError.orderIDGenerationFailed
        }
        self.orderId = generatedOrderId
    }
    
    @Test("Create a new payment session")
    func createSession() async throws {
        let session = Session(
            orderId: orderId,
            amount: "1.0",
            customerId: "TEST_CUSTOMER",
            customerEmail: "test@example.com",
            customerPhone: "1234567890",
            paymentPageClientId: merchantId,
            action: .paymentPage,
            returnUrl: "https://example.com/return"
        )
        
        let response = try await hyperCheckout.sessions.create(session: session)
        #expect(response.status == "CREATED")
        #expect(response.orderId == orderId)
        #expect(response.paymentLinks.web != nil)
    }
    
    @Test("Check order status")
    func checkOrderStatus() async throws {
        // First create a session to get a valid order
        let session = Session(
            orderId: orderId,
            amount: "1.0",
            customerId: "TEST_CUSTOMER",
            customerEmail: "test@example.com",
            customerPhone: "1234567890",
            paymentPageClientId: merchantId,
            action: .paymentPage,
            returnUrl: "https://example.com/return"
        )
        
        _ = try await hyperCheckout.sessions.create(session: session)
        
        // Then check the order status
        let order = try await hyperCheckout.orders.status(
            orderId: orderId,
            routingId: "TEST_CUSTOMER"
        )
        
        #expect(order.orderId == orderId)
        #expect(order.customerId == "TEST_CUSTOMER")
    }
    
    @Test("Process a refund")
    func processRefund() async throws {
        let refundRequest = RefundRequest(
            uniqueRequestId: RefundRequest.generateUniqueRequestID(),
            amount: 1.0
        )
        
        let response = try await hyperCheckout.refunds.request(
            orderId: orderId,
            routingId: "TEST_CUSTOMER",
            refund: refundRequest
        )
        
        #expect(response.orderId == orderId)
    }
}

enum TestError: Error {
    case environmentVariableNotFound(String)
    case orderIDGenerationFailed
} 
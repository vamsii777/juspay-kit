import Foundation
import NIO
import NIOHTTP1

public protocol RefundRoutes: JuspayAPIRoute {
    func create(orderId: String, refund: RefundRequest) async throws -> RefundResponse
}

public struct JuspayRefundRoutes: RefundRoutes {
    public var headers: HTTPHeaders = [:]
    private let apiHandler: JuspayAPIHandler
    
    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(orderId: String, refund: RefundRequest) async throws -> RefundResponse {
        let path = "orders/\(orderId)/refunds"
        var body = "unique_request_id=\(refund.uniqueRequestId)&amount=\(refund.amount)"
        body = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? body
        
        var _headers = headers
        _headers.add(name: "Content-Type", value: "application/x-www-form-urlencoded")
        _headers.add(name: "version", value: DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none))
        
        return try await apiHandler.send(method: .POST, path: path, body: .string(body), headers: _headers)
    }
}

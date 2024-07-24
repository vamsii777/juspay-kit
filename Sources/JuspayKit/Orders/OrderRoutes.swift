import NIO
import NIOHTTP1

public protocol OrderRoutes: JuspayAPIRoute {
    func retrieve(orderId: String) async throws -> Order
    func create(parameters: [String: Any]) async throws -> OrderCreationResponse
}

public struct JuspayOrderRoutes: OrderRoutes {
    public var headers: HTTPHeaders = [:]
    let apiHandler: JuspayAPIHandler
    
    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve(orderId: String) async throws -> Order {
        return try await apiHandler.send(method: .GET, path: "orders/\(orderId)", headers: headers)
    }
    
    public func create(parameters: [String: Any]) async throws -> OrderCreationResponse {
        do {
            return try await apiHandler.send(method: .POST, path: "orders", body: .string(parameters.percentEncoded()), headers: headers)
        } catch let error as JuspayError {
            switch error {
            case .invalidInput(let message):
                throw JuspayError.orderCreationFailed(message: "Invalid input: \(message)")
            case .authenticationFailed:
                throw JuspayError.authenticationFailed
            case .serverError(let message):
                throw JuspayError.serverError(message: "Server error during order creation: \(message)")
            case .orderCreationFailed(let message):
                throw JuspayError.orderCreationFailed(message: message)
            }
        }
    }
}

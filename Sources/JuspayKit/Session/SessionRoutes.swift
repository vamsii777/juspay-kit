import NIO
import Foundation
import NIOHTTP1

public protocol SessionRoutes: JuspayAPIRoute {
    func create(session: Session) async throws -> SessionResponse
}

public struct JuspaySessionRoutes: SessionRoutes {
    public var headers: HTTPHeaders = [:]
    private let apiHandler: JuspayAPIHandler
    
    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(session: Session) async throws -> SessionResponse {
        let body = try JSONEncoder().encode(session)
        return try await apiHandler.send(method: .POST, path: "session", body: .data(body), headers: headers)
    }
}

import NIO
import NIOHTTP1

public protocol HealthCheckRoutes: JuspayAPIRoute {
    func check() async throws -> JuspayHealthStatus
}

public struct JuspayHealthRoutes: HealthCheckRoutes {
    /// The HTTP headers to be sent with each request.
    public var headers: HTTPHeaders = [:]

    private let apiHandler: JuspayAPIHandler

    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }

    /// Performs a health check on the Juspay API.
    ///
    /// - Returns: A `JuspayHealthStatus` indicating the current status of the Juspay API.
    /// - Throws: An error if the health check request fails.
    public func check() async throws -> JuspayHealthStatus {
        try await apiHandler.send(
            healthCheck: true,
            method: .GET, path: "/summary.json", headers: headers
        )
    }
}

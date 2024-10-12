import NIO
import NIOHTTP1

/// A protocol representing a route for the Juspay API.
public protocol JuspayAPIRoute {
    /// The HTTP headers associated with the API route.
    var headers: HTTPHeaders { get set }

    /// Adds new headers to the existing headers of the API route.
    ///
    /// - Parameter headers: The new headers to add.
    /// - Returns: The modified `JuspayAPIRoute` instance.
    mutating func addHeaders(_ headers: HTTPHeaders) -> Self
}

public extension JuspayAPIRoute {
    /// Default implementation for adding headers to the API route.
    ///
    /// This method adds the provided headers to the existing headers of the API route.
    /// If a header with the same name already exists, it will be replaced with the new value.
    ///
    /// - Parameter headers: The new headers to add.
    /// - Returns: The modified `JuspayAPIRoute` instance.
    mutating func addHeaders(_ headers: HTTPHeaders) -> Self {
        headers.forEach { self.headers.replaceOrAdd(name: $0.name, value: $0.value) }
        return self
    }
}

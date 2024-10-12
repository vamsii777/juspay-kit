import NIO
import NIOHTTP1

public protocol JuspayAPIRoute {
    var headers: HTTPHeaders { get set }
    
    mutating func addHeaders(_ headers: HTTPHeaders) -> Self
}

extension JuspayAPIRoute {
    public mutating func addHeaders(_ headers: HTTPHeaders) -> Self {
        headers.forEach { self.headers.replaceOrAdd(name: $0.name, value: $0.value) }
        return self
    }
}
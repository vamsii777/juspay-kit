public extension Dictionary {
    var queryParameters: String {
        self.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
}

public extension Dictionary where Key == String, Value == Any {
    func percentEncoded() -> String {
        return self.map { key, value in
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "\(value)"
            return escapedKey + "=" + escapedValue
        }.joined(separator: "&")
    }
}

/// Extension on Dictionary providing utility methods for query parameter encoding.
public extension Dictionary {
    /// Converts the dictionary into a URL query string.
    ///
    /// This property creates a string representation of the dictionary suitable for use as URL query parameters.
    /// Each key-value pair is converted to the format "key=value", and pairs are joined with "&" characters.
    ///
    /// - Note: This method does not perform any URL encoding. For URL-safe encoding, use `percentEncoded()` instead.
    ///
    /// - Returns: A string representation of the dictionary as URL query parameters.
    ///
    /// - Example:
    ///   ```swift
    ///   let params = ["name": "John", "age": 30]
    ///   print(params.queryParameters) // Outputs: "name=John&age=30"
    ///   ```
    var queryParameters: String {
        self.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
}

/// Extension on Dictionary specifically for String keys and Any values, providing URL-safe encoding.
public extension Dictionary where Key == String, Value == Any {
    /// Encodes the dictionary into a URL-safe query string.
    ///
    /// This method creates a percent-encoded string representation of the dictionary,
    /// suitable for use in URLs. Both keys and values are encoded to ensure URL safety.
    ///
    /// - Note: This method uses `addingPercentEncoding(withAllowedCharacters:)` for encoding,
    ///         which replaces characters that are not allowed in URL query parameters with percent-encoded equivalents.
    ///
    /// - Returns: A percent-encoded string representation of the dictionary.
    ///
    /// - Example:
    ///   ```swift
    ///   let params = ["name": "John Doe", "query": "Swift & Objective-C"]
    ///   print(params.percentEncoded()) // Outputs: "name=John%20Doe&query=Swift%20%26%20Objective-C"
    ///   ```
    func percentEncoded() -> String {
        return self.map { key, value in
            let escapedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? key
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "\(value)"
            return escapedKey + "=" + escapedValue
        }.joined(separator: "&")
    }
}

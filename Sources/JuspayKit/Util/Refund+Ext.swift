import Foundation

extension RefundRequest {
    /// Generates a unique request ID for the refund request.
    ///
    /// The generated request ID will be a string of 20 characters, always starting with 'R',
    /// followed by 19 random alphanumeric characters.
    /// This ID should not be reused for different refund requests to avoid processing duplicates.
    /// Special characters are avoided to ensure compatibility with various gateways and aggregators.
    ///
    /// - Returns: A randomly generated unique request ID string of 20 characters, starting with 'R'.
    public static func generateUniqueRequestID() -> String {
        let characters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        var uniqueRequestID = "R"
        var lastChar: Character?
        var sequentialCount = 0

        while uniqueRequestID.count < 20 {
            guard let randomChar = characters.randomElement() else { continue }
            
            // Check for sequential characters
            if let last = lastChar, let lastIndex = characters.firstIndex(of: last), let currentIndex = characters.firstIndex(of: randomChar) {
                if currentIndex == lastIndex + 1 {
                    sequentialCount += 1
                } else {
                    sequentialCount = 0
                }
            }
            
            // Avoid adding the same character consecutively or more than two sequential characters
            if randomChar != lastChar && sequentialCount < 2 {
                uniqueRequestID.append(randomChar)
                lastChar = randomChar
            }
        }
        
        return uniqueRequestID
    }
}
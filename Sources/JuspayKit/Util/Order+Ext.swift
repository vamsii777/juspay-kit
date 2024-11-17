import Foundation

/// A utility structure for generating order IDs.
extension Order {
    /// An array of characters used for generating order IDs.
    private static let characters = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

    /// Generates a random order ID of the specified length.
    ///
    /// The generated order ID will be a string of random characters from the `characters` array, always starting with 'O'.
    /// The length of the order ID must be between 2 and 20 characters, inclusive.
    /// The function ensures that no two consecutive characters are the same and that there are no more than two sequential characters.
    ///
    /// - Parameter length: The length of the order ID to generate. The default value is 20.
    /// - Returns: A randomly generated order ID string, or `nil` if the specified length is out of the valid range.
    public static func generateOrderID(length: Int = 20) -> String? {
        guard (2 ... 20).contains(length) else { return nil }

        var orderID = "O"
        var lastChar: Character?
        var sequentialCount = 0

        while orderID.count < length {
            guard let randomChar = characters.randomElement() else { return nil }

            // Check for sequential characters
            if let last = lastChar, let lastIndex = characters.firstIndex(of: last), let currentIndex = characters.firstIndex(of: randomChar) {
                if currentIndex == lastIndex + 1 {
                    sequentialCount += 1
                } else {
                    sequentialCount = 0
                }
            }

            // Avoid adding the same character consecutively or sequential characters
            if randomChar != lastChar, sequentialCount < 2 {
                orderID.append(randomChar)
                lastChar = randomChar
            }
        }

        return orderID
    }
}

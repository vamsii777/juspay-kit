# JuspayKit

[![Swift Versions](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fvamsii777%2Fjuspay-kit%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/vamsii777/juspay-kit)
[![Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fvamsii777%2Fjuspay-kit%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/vamsii777/juspay-kit)

Juspay Kit is a Swift package designed to facilitate seamless integration with Juspay’s payment processing APIs.

> ⚠️ Note: This library is under active development, and features may be subject to change. Feedback, bug reports, and contributions are appreciated!

## Requirements

- **Swift**: 5.8 or later
- **Platforms Supported**:
  - macOS 12.0+
  - iOS 15.0+
  - tvOS 15.0+
  - watchOS 8.0+

## Installation

### Swift Package Manager (SPM)

Add JuspayKit as a dependency in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/vamsii777/juspay-kit.git", .upToNextMajor(from: "0.1.7"))
]
```

Then add `JuspayKit` as a dependency to your target:

```swift
.product(name: "JuspayKit", package: "juspay-kit")
```

## Getting Started

### Client Initialization

The main entry point for interacting with Juspay APIs is `JuspayClient`. Initialize the client by providing an HTTP client, API key, merchant ID, and environment setting.

```swift
import JuspayKit

let client = JuspayClient(
    httpClient: HTTPClient.shared,
    apiKey: "your_api_key",
    merchantId: "your_merchant_id",
    environment: .sandbox // Use .production for live environment
)
```

### Creating a Payment Session

To create a payment session, prepare a `Session` object with order and customer details.

```swift
let session = Session(
    orderId: "O123456789",
    amount: "100.00",
    customerId: "CUST123",
    customerEmail: "customer@example.com",
    customerPhone: "1234567890",
    paymentPageClientId: "your_merchant_id",
    action: .paymentPage,
    returnUrl: "https://your-return-url.com"
)

do {
    let response = try await client.sessions.create(session: session)
    print("Session created with ID: \(response.id)")
} catch {
    print("Error creating session: \(error)")
}
```

### Fetching Payment Methods

Retrieve a list of supported payment methods by invoking `list()` on the `paymentMethods` object.

```swift
do {
    let methods = try await client.paymentMethods.list(
        addEmandatePaymentMethods: true,
        checkWalletDirectDebitSupport: true,
        addSupportedReferenceIds: true,
        addTpvPaymentMethods: true,
        addOutage: true
    )
    print("Available payment methods: \(methods.paymentMethods)")
} catch {
    print("Error fetching payment methods: \(error)")
}
```

### Processing Refunds

To issue a refund, create a `RefundRequest` and call `create()` on the `refunds` object.

```swift
let refundRequest = RefundRequest(
    uniqueRequestId: RefundRequest.generateUniqueRequestID(),
    amount: 50.00
)

do {
    let refund = try await client.refunds.create(
        orderId: "ORDER123",
        refund: refundRequest
    )
    print("Refund processed: \(refund.status ?? "Unknown")")
} catch {
    print("Error processing refund: \(error)")
}
```

### Health Check

Perform a health check to ensure Juspay API availability.

```swift
do {
    let health = try await client.health.check()
    print("API Status: \(health.page.status)")
} catch {
    print("Error checking health: \(error)")
}
```

## Error Handling

JuspayKit offers robust error handling via the `JuspayError` type, which includes detailed error codes and messages.

```swift
do {
    let order = try await client.orders.retrieve(orderId: "ORDER123")
} catch let error as JuspayError {
    print("Error code: \(error.errorCode ?? "Unknown")")
    print("Error message: \(error.errorMessage ?? "No message")")
} catch {
    print("Unexpected error: \(error)")
}
```

## Documentation

Detailed API documentation can be found at [API Documentation](https://vamsii777.github.io/juspay-kit/documentation/juspaykit).

## Security

Please refer to our [Security Policy](SECURITY.md) for security-related concerns.

## Contributing

Contributions are always welcome! Before submitting a pull request, please read our [Contributing Guidelines](CONTRIBUTING.md).

## License

JuspayKit is available under the MIT license. See the [LICENSE](LICENSE) file for more information.
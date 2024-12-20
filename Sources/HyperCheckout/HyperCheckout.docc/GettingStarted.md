# Getting Started with HyperCheckout

Learn how to integrate Juspay's HyperCheckout payment solution into your application.

## Overview

The HyperCheckout framework provides a simplified interface for integrating Juspay's payment processing capabilities into your application. It wraps the core JuspayKit functionality with HyperCheckout-specific implementations for managing orders, payment sessions, and refunds.

### Initialize the Client

First, create a JuspayClient with your API credentials and then use it to initialize the HyperCheckout client:

```swift
let juspayClient = JuspayClient(apiKey: "YOUR_API_KEY", apiSecret: "YOUR_API_SECRET", environment: .sandbox)
let hyperCheckoutClient = HyperCheckoutClient(juspayClient: juspayClient)
```

### Create a Payment Session

To create a payment session, use the `create` method of the HyperCheckout client:

```swift
let session = Session(
    amount: "100.00",
    customerId: "CUST123",
    customerEmail: "customer@example.com",
    customerPhone: "1234567890",
    paymentPageClientId: merchantId,
    action: .paymentPage,
    returnUrl: "https://merchant.com/return"
)
```

### Get Order Status

To get the status of an order, use the `status` method of the HyperCheckout client:

```swift
let order = try await hyperCheckoutClient.orders.status(orderId: "ORDER123", routingId: "CUST123")
```

### Process a Refund

To process a refund, use the `refund` method of the HyperCheckout client:

```swift
let refundRequest = RefundRequest(
    uniqueRequestId: "REFUND123",
    amount: 50.00,
    reason: "Customer request"
)
let refund = try await hyperCheckoutClient.refunds.create(orderId: "ORDER123", routingId: "CUST123", refund: refundRequest)
``` 

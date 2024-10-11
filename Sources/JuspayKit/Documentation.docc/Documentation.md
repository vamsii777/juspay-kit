# ``JuspayKit``

A Swift package for seamless integration with Juspay's payment processing APIs.

## Overview

JuspayKit provides a comprehensive set of tools for interacting with Juspay's payment gateway. It offers a thread-safe, concurrent interface to access various Juspay API endpoints, including customers, orders, payment methods, sessions, and refunds.

## Topics

### Essentials

- ``JuspayClient``
- ``Environment``

### Customer Management

- ``CustomerRoutes``
- ``Customer``
- ``JuspayCustomerRoutes``

### Order Processing

- ``OrderRoutes``
- ``Order``
- ``OrderCreationResponse``
- ``JuspayOrderRoutes``

### Payment Methods

- ``PaymentMethodRoutes``
- ``PaymentMethod``
- ``PaymentMethodsResponse``
- ``JuspayPaymentMethodRoutes``

### Session Management

- ``SessionRoutes``
- ``Session``
- ``SessionResponse``
- ``JuspaySessionRoutes``

### Refund Processing

- ``RefundRoutes``
- ``RefundRequest``
- ``RefundResponse``
- ``JuspayRefundRoutes``

### Health Check

- ``HealthCheckRoutes``
- ``JuspayHealthStatus``
- ``JuspayHealthRoutes``

### Error Handling

- ``JuspayError``

## JuspayClient

The main entry point for interacting with the Juspay API.

### Initialization

To create a new instance of `JuspayClient`:

```swift
let client = JuspayClient(httpClient: httpClient, apiKey: apiKey, merchantId: merchantId, environment: environment)
```

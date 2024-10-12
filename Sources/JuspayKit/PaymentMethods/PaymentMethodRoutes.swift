import NIO
import NIOHTTP1

/// A protocol defining the payment method-related API routes for the Juspay payment gateway.
///
/// This protocol extends `JuspayAPIRoute` and provides methods for retrieving available payment methods
/// with various options to customize the response.
public protocol PaymentMethodRoutes: JuspayAPIRoute {
    /// Retrieves a list of available payment methods from the Juspay system.
    ///
    /// - Parameters:
    ///   - addEmandatePaymentMethods: A boolean flag to include e-mandate payment methods in the response.
    ///   - checkWalletDirectDebitSupport: A boolean flag to check and include wallet direct debit support information.
    ///   - addSupportedReferenceIds: A boolean flag to include supported reference IDs for payment methods.
    ///   - addTpvPaymentMethods: A boolean flag to include TPV (Third Party Validation) payment methods.
    ///   - addOutage: A boolean flag to include information about any ongoing outages for payment methods.
    ///
    /// - Returns: A `PaymentMethodsResponse` object containing the list of available payment methods and related information.
    ///
    /// - Throws: An error if the retrieval fails or if there's a network issue.
    func list(addEmandatePaymentMethods: Bool, checkWalletDirectDebitSupport: Bool, addSupportedReferenceIds: Bool, addTpvPaymentMethods: Bool, addOutage: Bool) async throws -> PaymentMethodsResponse
}

/// A concrete implementation of the `PaymentMethodRoutes` protocol for interacting with Juspay's payment method API.
public struct JuspayPaymentMethodRoutes: PaymentMethodRoutes {
    /// The HTTP headers to be sent with each request.
    public var headers: HTTPHeaders = [:]

    /// The API handler responsible for making network requests.
    private let apiHandler: JuspayAPIHandler

    /// Initializes a new instance of `JuspayPaymentMethodRoutes`.
    ///
    /// - Parameter apiHandler: The `JuspayAPIHandler` instance to use for API requests.
    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }

    /// Retrieves a list of available payment methods from the Juspay system.
    ///
    /// This method constructs a query string based on the provided parameters and sends a GET request
    /// to the Juspay API to retrieve the list of payment methods.
    ///
    /// - Parameters:
    ///   - addEmandatePaymentMethods: A boolean flag to include e-mandate payment methods. Defaults to `false`.
    ///   - checkWalletDirectDebitSupport: A boolean flag to check wallet direct debit support. Defaults to `false`.
    ///   - addSupportedReferenceIds: A boolean flag to include supported reference IDs. Defaults to `false`.
    ///   - addTpvPaymentMethods: A boolean flag to include TPV payment methods. Defaults to `false`.
    ///   - addOutage: A boolean flag to include outage information. Defaults to `false`.
    ///
    /// - Returns: A `PaymentMethodsResponse` object containing the list of available payment methods and related information.
    ///
    /// - Throws: An error if the retrieval fails or if there's a network issue.
    public func list(addEmandatePaymentMethods: Bool = false, checkWalletDirectDebitSupport: Bool = false, addSupportedReferenceIds: Bool = false, addTpvPaymentMethods: Bool = false, addOutage: Bool = false) async throws -> PaymentMethodsResponse {
        var query = ""
        if addEmandatePaymentMethods {
            query += "options.add_emandate_payment_methods=true&"
        }
        if checkWalletDirectDebitSupport {
            query += "options.check_wallet_direct_debit_support=true&"
        }
        if addSupportedReferenceIds {
            query += "options.add_supported_reference_ids=true&"
        }
        if addTpvPaymentMethods {
            query += "options.add_tpv_payment_methods=true&"
        }
        if addOutage {
            query += "options.add_outage=true&"
        }
        query = String(query.dropLast())
        return try await apiHandler.send(method: .GET, path: "merchants/guest/paymentmethods", query: query, headers: headers)
    }
}

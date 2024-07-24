import NIO
import NIOHTTP1

public protocol PaymentMethodRoutes: JuspayAPIRoute {
    func list(addEmandatePaymentMethods: Bool, checkWalletDirectDebitSupport: Bool, addSupportedReferenceIds: Bool, addTpvPaymentMethods: Bool, addOutage: Bool) async throws -> PaymentMethodsResponse
}

public struct JuspayPaymentMethodRoutes: PaymentMethodRoutes {
    public var headers: HTTPHeaders = [:]
    private let apiHandler: JuspayAPIHandler
    
    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }
    
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

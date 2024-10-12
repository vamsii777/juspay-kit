import Foundation

public struct OrderRequest: Codable {
    public let orderId: String
    public let amount: String
    public let customerId: String
    public let customerEmail: String
    public let customerPhone: String
    public let paymentPageClientId: String
    public let action: String
    public let returnUrl: String
    public let firstName: String?
    public let lastName: String?
    public let description: String?
    public let currency: String?
    public let orderType: String?
    public let language: String?
    public let metadata: Metadata?
    public let options: Options
    public let mandate: Mandate?
    public let udf: UDF?
    
    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case amount
        case customerId = "customer_id"
        case customerEmail = "customer_email"
        case customerPhone = "customer_phone"
        case paymentPageClientId = "payment_page_client_id"
        case action
        case returnUrl = "return_url"
        case firstName = "first_name"
        case lastName = "last_name"
        case description
        case currency
        case orderType = "order_type"
        case language
        case metadata
        case options
        case mandate
        case udf
    }
}

public struct Metadata: Codable {
    public let juspayGatewayReferenceId: String?
    public let webhookUrl: String?
    public let bankAccountDetails: [String]?
    public let expiryInMins: String?
    public let txnsAllowCardNo3DS: Bool?
    
    enum CodingKeys: String, CodingKey {
        case juspayGatewayReferenceId = "JUSPAY:gateway_reference_id"
        case webhookUrl = "webhook_url"
        case bankAccountDetails = "bank_account_details"
        case expiryInMins = "expiryInMins"
        case txnsAllowCardNo3DS = "txns.allow_card_no_3ds"
    }
}

public struct Options: Codable {
    public let createMandate: String
    
    enum CodingKeys: String, CodingKey {
        case createMandate = "create_mandate"
    }
}

public struct Mandate: Codable {
    public let maxAmount: String
    public let startDate: String?
    public let endDate: String?
    public let frequency: String?
    public let ruleValue: String?
    public let amountRule: String?
    public let blockFunds: Bool?
    
    enum CodingKeys: String, CodingKey {
        case maxAmount = "mandate.max_amount"
        case startDate = "mandate.start_date"
        case endDate = "mandate.end_date"
        case frequency = "mandate.frequency"
        case ruleValue = "mandate.rule_value"
        case amountRule = "mandate.amount_rule"
        case blockFunds = "mandate.block_funds"
    }
}

public struct UDF: Codable {
    public let udf1: String?
    public let udf2: String?
    public let udf3: String?
    public let udf4: String?
    public let udf5: String?
    public let udf6: String?
    public let udf7: String?
    public let udf8: String?
    public let udf9: String?
    public let udf10: String?
}

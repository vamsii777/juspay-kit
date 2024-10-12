//
//  CustomerRoutes.swift
//  
//
//  Created by Vamsi Madduluri on 24/07/24.
//

import NIO
import NIOHTTP1

public protocol CustomerRoutes: JuspayAPIRoute {
    func create(objectReferenceId: String, mobileNumber: String, emailAddress: String, firstName: String, lastName: String, mobileCountryCode: String, getClientAuthToken: Bool) async throws -> Customer
    func retrieve(customerId: String, getClientAuthToken: Bool) async throws -> Customer
}

public struct JuspayCustomerRoutes: CustomerRoutes {
    public var headers: HTTPHeaders = [:]
     private let apiHandler: JuspayAPIHandler
    
    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }

    public func create(objectReferenceId: String, mobileNumber: String, emailAddress: String, firstName: String, lastName: String, mobileCountryCode: String, getClientAuthToken: Bool = false) async throws -> Customer {
        var body = [
            "object_reference_id": objectReferenceId,
            "mobile_number": mobileNumber,
            "email_address": emailAddress,
            "first_name": firstName,
            "last_name": lastName,
            "mobile_country_code": mobileCountryCode
        ]
        
        if getClientAuthToken {
            body["options.get_client_auth_token"] = "true"
        }
        
        return try await apiHandler.send(method: .POST, path: "customers", body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(customerId: String, getClientAuthToken: Bool = false) async throws -> Customer {
        var query = ""
        if getClientAuthToken {
            query = "options.get_client_auth_token=true"
        }
        return try await apiHandler.send(method: .GET, path: "customers/\(customerId)", query: query, headers: headers)
    }
}

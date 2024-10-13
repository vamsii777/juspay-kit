//
//  CustomerRoutes.swift
//
//
//  Created by Vamsi Madduluri on 24/07/24.
//

import NIO
import NIOHTTP1

/// A protocol defining the customer-related API routes for the Juspay payment gateway.
///
/// This protocol extends `JuspayAPIRoute` and provides methods for creating and retrieving customer information.
public protocol CustomerRoutes: JuspayAPIRoute {
    /// Creates a new customer in the Juspay system.
    ///
    /// - Parameters:
    ///   - objectReferenceId: A unique identifier for the customer in your system.
    ///   - mobileNumber: The customer's mobile phone number.
    ///   - emailAddress: The customer's email address.
    ///   - firstName: The customer's first name.
    ///   - lastName: The customer's last name.
    ///   - mobileCountryCode: The country code for the customer's mobile number.
    ///   - getClientAuthToken: A boolean flag indicating whether to generate a client authentication token.
    ///
    /// - Returns: A `Customer` object representing the newly created customer.
    ///
    /// - Throws: An error if the customer creation fails or if there's a network issue.
    func create(objectReferenceId: String, mobileNumber: String, emailAddress: String, firstName: String, lastName: String, mobileCountryCode: String, getClientAuthToken: Bool) async throws -> Customer
    
    /// Retrieves an existing customer from the Juspay system.
    ///
    /// - Parameters:
    ///   - customerId: The unique identifier of the customer in the Juspay system.
    ///   - getClientAuthToken: A boolean flag indicating whether to retrieve a new client authentication token.
    ///
    /// - Returns: A `Customer` object representing the retrieved customer.
    ///
    /// - Throws: An error if the customer retrieval fails or if there's a network issue.
    func retrieve(customerId: String, getClientAuthToken: Bool) async throws -> Customer
}

/// A concrete implementation of the `CustomerRoutes` protocol for interacting with Juspay's customer API.
public struct JuspayCustomerRoutes: CustomerRoutes {
    /// The HTTP headers to be sent with each request.
    public var headers: HTTPHeaders = [:]
    
    /// The API handler responsible for making network requests.
    private let apiHandler: JuspayAPIHandler
    
    /// Initializes a new instance of `JuspayCustomerRoutes`.
    ///
    /// - Parameter apiHandler: The `JuspayAPIHandler` instance to use for API requests.
    init(apiHandler: JuspayAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    /// Creates a new customer in the Juspay system.
    ///
    /// This method sends a POST request to the Juspay API to create a new customer with the provided information.
    ///
    /// - Parameters:
    ///   - objectReferenceId: A unique identifier for the customer in your system.
    ///   - mobileNumber: The customer's mobile phone number.
    ///   - emailAddress: The customer's email address.
    ///   - firstName: The customer's first name.
    ///   - lastName: The customer's last name.
    ///   - mobileCountryCode: The country code for the customer's mobile number.
    ///   - getClientAuthToken: A boolean flag indicating whether to generate a client authentication token. Defaults to `false`.
    ///
    /// - Returns: A `Customer` object representing the newly created customer.
    ///
    /// - Throws: An error if the customer creation fails or if there's a network issue.
    public func create(objectReferenceId: String, mobileNumber: String, emailAddress: String, firstName: String, lastName: String, mobileCountryCode: String, getClientAuthToken: Bool = false) async throws -> Customer {
        var body = [
            "object_reference_id": objectReferenceId,
            "mobile_number": mobileNumber,
            "email_address": emailAddress,
            "first_name": firstName,
            "last_name": lastName,
            "mobile_country_code": mobileCountryCode,
        ]
        
        if getClientAuthToken {
            body["options.get_client_auth_token"] = "true"
        }
        
        return try await apiHandler.send(method: .POST, path: "customers", body: .string(body.queryParameters), headers: headers)
        
    }
    
    /// Retrieves an existing customer from the Juspay system.
    ///
    /// This method sends a GET request to the Juspay API to retrieve the customer information for the specified customer ID.
    ///
    /// - Parameters:
    ///   - customerId: The unique identifier of the customer in the Juspay system.
    ///   - getClientAuthToken: A boolean flag indicating whether to retrieve a new client authentication token. Defaults to `false`.
    ///
    /// - Returns: A `Customer` object representing the retrieved customer.
    ///
    /// - Throws: An error if the customer retrieval fails or if there's a network issue.
    public func retrieve(customerId: String, getClientAuthToken: Bool = false) async throws -> Customer {
        var query = ""
        if getClientAuthToken {
            query = "options.get_client_auth_token=true"
        }
        return try await apiHandler.send(method: .GET, path: "customers/\(customerId)", query: query, headers: headers)
    }
}

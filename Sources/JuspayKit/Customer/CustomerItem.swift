//
//  CustomerItem.swift
//  
//
//  Created by Vamsi Madduluri on 24/07/24.
//

import Foundation

/// A structure representing a customer in the Juspay system.
///
/// This struct encapsulates all the relevant information about a customer,
/// including personal details and Juspay-specific information.
///
/// - Important: All properties are immutable to ensure data integrity.
public struct Customer: Codable, Sendable {
    /// The unique identifier for the customer.
    public let id: String
    
    /// The type of object, typically "customer".
    public let object: String
    
    /// An external reference ID for the customer.
    public let objectReferenceId: String
    
    /// The customer's mobile phone number.
    public let mobileNumber: String
    
    /// The date and time when the customer record was created.
    public let dateCreated: Date
    
    /// The date and time when the customer record was last updated.
    public let lastUpdated: Date
    
    /// The customer's email address.
    public let emailAddress: String
    
    /// The customer's first name.
    public let firstName: String
    
    /// The customer's last name.
    public let lastName: String
    
    /// The country code for the customer's mobile number.
    public let mobileCountryCode: String
    
    /// Additional Juspay-specific information for the customer.
    /// This property is optional and may be `nil`.
    public let juspay: JuspayInfo?
}

/// A structure containing Juspay-specific information for a customer.
public struct JuspayInfo: Codable, Sendable {
    /// The authentication token for the customer.
    public let clientAuthToken: String
    
    /// The expiration date and time for the client authentication token.
    public let clientAuthTokenExpiry: Date
}

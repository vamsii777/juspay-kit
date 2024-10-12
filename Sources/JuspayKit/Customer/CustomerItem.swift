//
//  CustomerItem.swift
//  
//
//  Created by Vamsi Madduluri on 24/07/24.
//

import Foundation

public struct Customer: Codable {
    public let id: String
    public let object: String
    public let objectReferenceId: String
    public let mobileNumber: String
    public let dateCreated: Date
    public let lastUpdated: Date
    public let emailAddress: String
    public let firstName: String
    public let lastName: String
    public let mobileCountryCode: String
    public let juspay: JuspayInfo?
}

public struct JuspayInfo: Codable {
    public let clientAuthToken: String
    public let clientAuthTokenExpiry: Date
}

//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Requisition: Codable, Hashable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id
        case created
        case redirect
        case agreement
        case status
        case institutionId = "institution_id"
        case reference
        case accounts
        case userLanguage = "user_language"
        case link
        case ssn
        case accountSelection
        case redirectImmediate
    }
    
    public enum Status: String, Codable, Hashable, Equatable {
        case created = "CR"
        case givingConsent = "GC"
        case undergoingAuthentication = "UA"
        case rejected = "RJ"
        case selecting_accounts = "SA"
        case grantingAccess = "GA"
        case linked = "LN"
        case suspended = "SU"
        case expired = "EX"
    }
    
    public let id: String

    /// The date & time at which the requisition was created.
    public let created: Date?

    /// redirect URL to your application after end-user authorization with ASPSP
    public let redirect: String?

    /// status of this requisition
    public let status: Status

    /// an Institution ID for this Requisition
    public let institutionId: String

    /// EUA associated with this requisition
    public let agreement: String

    /// additional ID to identify the end user
    public let reference: String

    /// array of account IDs retrieved within a scope of this requisition
    public let accounts: [String]

    /// A two-letter country code (ISO 639-1)
    public let userLanguage: String?

    /// link to initiate authorization with Institution
    public let link: String

    /// optional SSN field to verify ownership of the account
    public let ssn: String?

    /// option to enable account selection view for the end user
    public let accountSelection: Bool?

    /// enable redirect back to the client after account list received
    public let redirectImmediate: Bool?

    public init(id: String, created: Date?, redirect: String?, status: Status, institutionId: String, agreement: String, reference: String, accounts: [String], userLanguage: String?, link: String, ssn: String?, accountSelection: Bool?, redirectImmediate: Bool?) {
        self.id = id
        self.created = created
        self.redirect = redirect
        self.status = status
        self.institutionId = institutionId
        self.agreement = agreement
        self.reference = reference
        self.accounts = accounts
        self.userLanguage = userLanguage
        self.link = link
        self.ssn = ssn
        self.accountSelection = accountSelection
        self.redirectImmediate = redirectImmediate
    }
}

//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Requisition: Codable, Equatable {
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
    
    public enum Status: String, Codable {
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
    public let created: Date?
    public let redirect: String?
    public let status: Status
    public let institutionId: String
    public let agreement: String
    public let reference: String
    public let accounts: [String]
    public let userLanguage: String?
    public let link: String
    public let ssn: String?
    public let accountSelection: Bool?
    public let redirectImmediate: Bool?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        var created: Date? = nil
        if let _created = try container.decodeIfPresent(String.self, forKey: .created) {
            created = DateFormatters.isoDateFormatter.date(from: _created)
        }
        
        self.created = created
        
        redirect = try container.decodeIfPresent(String.self, forKey: .redirect)
        status = try container.decode(Status.self, forKey: .status)
        institutionId = try container.decode(String.self, forKey: .institutionId)
        agreement = try container.decode(String.self, forKey: .agreement)
        reference = try container.decode(String.self, forKey: .reference)
        accounts = try container.decode([String].self, forKey: .accounts)
        userLanguage = try container.decodeIfPresent(String.self, forKey: .userLanguage)
        link = try container.decode(String.self, forKey: .link)
        ssn = try container.decodeIfPresent(String.self, forKey: .ssn)
        accountSelection = try container.decodeIfPresent(Bool.self, forKey: .accountSelection)
        redirectImmediate = try container.decodeIfPresent(Bool.self, forKey: .redirectImmediate)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        if let created {
            try container.encode(DateFormatters.isoDateFormatter.string(from: created), forKey: .created)
        } else {
            try container.encode("", forKey: .created)
        }
        
        try container.encodeIfPresent(redirect, forKey: .redirect)
        try container.encode(status, forKey: .status)
        try container.encode(institutionId, forKey: .institutionId)
        try container.encode(agreement, forKey: .agreement)
        try container.encode(reference, forKey: .reference)
        try container.encode(accounts, forKey: .accounts)
        try container.encodeIfPresent(userLanguage, forKey: .userLanguage)
        try container.encode(link, forKey: .link)
        try container.encodeIfPresent(ssn, forKey: .ssn)
        try container.encodeIfPresent(accountSelection, forKey: .accounts)
        try container.encodeIfPresent(redirectImmediate, forKey: .redirectImmediate)
    }
}

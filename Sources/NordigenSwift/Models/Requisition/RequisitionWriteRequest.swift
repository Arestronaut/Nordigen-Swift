//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct RequisitionWriteRequest: Encodable {
    enum CodingKeys: String, CodingKey {
        case institutionId = "institution_id"
        case redirect
        case agreement
        case reference
        case userLanguage = "user_language"
        case ssn
        case accountSelection = "account_selection"
        case redirect_immediate = "redirect_immediate"
    }
    
    let institutionId: String
    let redirect: String
    let agreement: String?
    let reference: String?
    let userLanguage: String?
    let ssn: String?
    let accountSelection: Bool?
    let redirectImmediate: Bool?
    
    init(institutionId: String, redirect: String, agreement: String? = nil, reference: String? = nil, userLanguage: String? = nil, ssn: String? = nil, accountSelection: Bool? = nil, redirectImmediate: Bool? = nil) {
        self.institutionId = institutionId
        self.redirect = redirect
        self.agreement = agreement
        self.reference = reference
        self.userLanguage = userLanguage
        self.ssn = ssn
        self.accountSelection = accountSelection
        self.redirectImmediate = redirectImmediate
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(institutionId, forKey: .institutionId)
        try container.encode(redirect, forKey: .redirect)
        try container.encodeIfPresent(agreement, forKey: .agreement)
        try container.encodeIfPresent(reference, forKey: .reference)
        try container.encodeIfPresent(userLanguage, forKey: .userLanguage)
        try container.encodeIfPresent(ssn, forKey: .ssn)
        try container.encodeIfPresent(accountSelection, forKey: .accountSelection)
        try container.encodeIfPresent(redirectImmediate, forKey: .redirect_immediate)
    }
}

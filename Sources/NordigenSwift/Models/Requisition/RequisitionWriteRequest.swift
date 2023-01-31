//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct RequisitionWriteRequest: Codable, Hashable, Equatable {
    enum CodingKeys: String, CodingKey {
        case institutionId = "institution_id"
        case redirect
        case agreement
        case reference
        case userLanguage = "user_language"
        case ssn
        case accountSelection = "account_selection"
        case redirectImmediate = "redirect_immediate"
    }
    
    public let institutionId: String
    public let redirect: String
    public let agreement: String?
    public let reference: String?
    public let userLanguage: String?
    public let ssn: String?
    public let accountSelection: Bool?
    public let redirectImmediate: Bool?

    public init(institutionId: String, redirect: String, agreement: String? = nil, reference: String? = nil, userLanguage: String? = nil, ssn: String? = nil, accountSelection: Bool? = nil, redirectImmediate: Bool? = nil) {
        self.institutionId = institutionId
        self.redirect = redirect
        self.agreement = agreement
        self.reference = reference
        self.userLanguage = userLanguage
        self.ssn = ssn
        self.accountSelection = accountSelection
        self.redirectImmediate = redirectImmediate
    }
}

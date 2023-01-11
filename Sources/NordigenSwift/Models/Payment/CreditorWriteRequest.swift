//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct CreditorWriteRequest: Codable {
    public enum AddressCountry: String, Codable {
        case AT, BE, BG, HR, CY, CZ, DK, EE, FI, FR, DE, GR, HU, IS, IE, IT, LV, LI, LT, LU, MT, NL, NO, PL, PT, RO, SK, SI, ES, SE, GB
    }

    enum CodingKeys: String, CodingKey {
        case name
        case type
        case account
        case currency
        case addressCountry = "address_country"
        case institutionId = "institution_id"
        case agent
        case agentName = "agent_name"
        case addressStreet = "address_street"
        case postCode = "post_code"
    }

    public let name: String
    public let type: AccountType?
    public let account: String
    public let currency: String
    public let addressCountry: AddressCountry?
    public let institutionId: String?
    public let agent: String?
    public let agentName: String?
    public let addressStreet: String?
    public let postCode: String?
}

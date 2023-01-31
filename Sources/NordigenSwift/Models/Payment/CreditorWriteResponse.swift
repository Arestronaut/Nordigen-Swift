//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct CreditorWriteResponse: Codable, Hashable, Equatable {
    public enum AddressCountry: String, Codable {
        case AT, BE, BG, HR, CY, CZ, DK, EE, FI, FR, DE, GR, HU, IS, IE, IT, LV, LI, LT, LU, MT, NL, NO, PL, PT, RO, SK, SI, ES, SE, GB
    }

    enum CodingKeys: String, CodingKey {
        case id
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

    public let id: String?
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

    public init(id: String?, name: String, type: AccountType?, account: String, currency: String, addressCountry: AddressCountry?, institutionId: String?, agent: String?, agentName: String?, addressStreet: String?, postCode: String?) {
        self.id = id
        self.name = name
        self.type = type
        self.account = account
        self.currency = currency
        self.addressCountry = addressCountry
        self.institutionId = institutionId
        self.agent = agent
        self.agentName = agentName
        self.addressStreet = addressStreet
        self.postCode = postCode
    }
}

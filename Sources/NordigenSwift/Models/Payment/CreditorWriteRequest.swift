//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct CreditorWriteRequest: Codable, Hashable, Equatable {
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

    /// Creditor account name
    public let name: String

    /// Creditor account type
    public let type: AccountType?

    /// Creditor account identifier
    public let account: String

    /// Creditor account currency
    public let currency: String

    public let addressCountry: AddressCountry?

    /// an Institution ID for this CreditorAccount
    public let institutionId: String?

    /// Creditor account BICFI Identifier
    public let agent: String?

    /// Creditor account agent name
    public let agentName: String?

    /// Creditor account address street
    public let addressStreet: String?

    /// Creditor account address post code
    public let postCode: String?

    public init(name: String, type: AccountType?, account: String, currency: String, addressCountry: AddressCountry?, institutionId: String?, agent: String?, agentName: String?, addressStreet: String?, postCode: String?) {
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

//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct CreditorAccount: Codable, Hashable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case account
        case currency
        case addressCountry = "address_country"
    }

    /// Unique entry ID
    public let id: String

    /// Creditor account name
    public let name: String

    /// Creditor account type
    public let type: AccountType

    /// reditor account identifier
    public let account: String

    /// Creditor account currency
    public let currency: String // TODO: (Raoul 17/01/23) Use Currency enum

    /// Creditor account address country
    public let addressCountry: String // TODO: (Raoul 17/01/23) Use Country enum

    public init(id: String, name: String, type: AccountType, account: String, currency: String, addressCountry: String) {
        self.id = id
        self.name = name
        self.type = type
        self.account = account
        self.currency = currency
        self.addressCountry = addressCountry
    }
}

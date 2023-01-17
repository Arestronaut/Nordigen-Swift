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
    
    public let id: String
    public let name: String
    public let type: AccountType
    public let account: String
    public let currency: String
    public let addressCountry: String
}

//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Institution: Codable, Hashable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bic
        case transactionTotalDays = "transaction_total_days"
        case countries
        case logo
    }
    
    public let id: String
    public let name: String
    public let bic: String
    public let transactionTotalDays: String
    public let countries: [String]
    public let logo: String

    public init(id: String, name: String, bic: String, transactionTotalDays: String, countries: [String], logo: String) {
        self.id = id
        self.name = name
        self.bic = bic
        self.transactionTotalDays = transactionTotalDays
        self.countries = countries
        self.logo = logo
    }
}

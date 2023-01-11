//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public final class Institution: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bic
        case transactionTotalDays = "transaction_total_days"
        case countries
        case logo
    }
    
    let id: String
    let name: String
    let bic: String
    let transactionTotalDays: String
    let countries: [String]
    let logo: String
}

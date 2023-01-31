//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct MonetaryAmount: Codable, CustomStringConvertible, Equatable, Hashable {
    public let amount: String
    public let currency: String
    
    public var description: String {
        "\(amount)\(currency)"
    }

    public init(amount: String, currency: String) {
        self.amount = amount
        self.currency = currency
    }
}

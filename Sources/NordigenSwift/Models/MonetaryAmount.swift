//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct MonetaryAmount: Codable, CustomStringConvertible, Equatable, Hashable {
    let amount: String
    let currency: String
    
    public var description: String {
        "\(amount)\(currency)"
    }
}

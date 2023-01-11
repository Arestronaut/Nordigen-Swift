//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Balance: Codable {
    public let balanceAmount: MonetaryAmount
    public let balanceType: String
    public let referenceDate: String
}


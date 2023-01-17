//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Balance: Codable, Hashable, Equatable {
    public let balanceAmount: MonetaryAmount
    public let balanceType: String
    // TODO: Use Date
    public let referenceDate: String
}


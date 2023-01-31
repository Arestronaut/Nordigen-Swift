//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Balance: Codable, Hashable, Equatable {
    public let balanceAmount: MonetaryAmount
    public let balanceType: String
    public let referenceDate: Date

    public init(balanceAmount: MonetaryAmount, balanceType: String, referenceDate: Date) {
        self.balanceAmount = balanceAmount
        self.balanceType = balanceType
        self.referenceDate = referenceDate
    }
}


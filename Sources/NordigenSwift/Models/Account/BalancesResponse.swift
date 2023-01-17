//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct BalancesResponse: Codable, Hashable, Equatable {
    public let balances: [Balance]
}

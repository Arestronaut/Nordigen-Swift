//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct TransactionsResponse: Codable {
    public let booked: [Transaction]
    public let pending: [Transaction]
}

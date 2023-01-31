//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct AccountDetail: Codable, Hashable, Equatable {
    public let resourceId: String
    public let lban: String
    public let currency: String
    public let ownerName: String
    public let name: String
    public let product: String
    public let cashAccountType: String

    public init(resourceId: String, lban: String, currency: String, ownerName: String, name: String, product: String, cashAccountType: String) {
        self.resourceId = resourceId
        self.lban = lban
        self.currency = currency
        self.ownerName = ownerName
        self.name = name
        self.product = product
        self.cashAccountType = cashAccountType
    }
}

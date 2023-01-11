//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct AccountDetail: Codable {
    public let resourceId: String
    public let lban: String
    public let currency: String
    public let ownerName: String
    public let name: String
    public let product: String
    public let cashAccountType: String
}

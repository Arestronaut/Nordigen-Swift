//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct AccountDetailResponse: Codable, Hashable, Equatable {
    public let account: AccountDetail

    public init(account: AccountDetail) {
        self.account = account
    }
}

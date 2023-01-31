//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct EndUserAgreementAcceptance: Codable, Hashable, Equatable {
    enum CodingKeys: String, CodingKey {
        case userAgent = "user_agent"
        case ipAddress = "ip_address"
    }

    /// user agent string for the end user
    public let userAgent: String

    /// end user IP address
    public let ipAddress: String

    public init(userAgent: String, ipAddress: String) {
        self.userAgent = userAgent
        self.ipAddress = ipAddress
    }
}

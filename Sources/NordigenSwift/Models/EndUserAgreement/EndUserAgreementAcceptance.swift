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
    
    public let userAgent: String
    public let ipAddress: String
}

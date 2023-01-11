//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public final class EndUserAgreementAcceptance: Codable {
    enum CodingKeys: String, CodingKey {
        case userAgent = "user_agent"
        case ipAddress = "ip_address"
    }
    
    let userAgent: String
    let ipAddress: String
}

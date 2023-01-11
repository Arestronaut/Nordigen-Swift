//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

struct AccessToken: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case access
        case accessExpires = "access_expires"
        case refresh
        case refreshExpires = "refresh_expires"
    }
    
    var access: String
    var accessExpires: Int
    var refresh: String?
    var refreshExpires: Int?
}

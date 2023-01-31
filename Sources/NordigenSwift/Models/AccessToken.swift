//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct AccessToken: Codable, Hashable, Equatable {
    public enum CodingKeys: String, CodingKey {
        case access
        case accessExpires = "access_expires"
        case refresh
        case refreshExpires = "refresh_expires"
    }
    
    public var access: String
    public var accessExpires: Int
    public var refresh: String?
    public var refreshExpires: Int?

    public init(access: String, accessExpires: Int, refresh: String? = nil, refreshExpires: Int? = nil) {
        self.access = access
        self.accessExpires = accessExpires
        self.refresh = refresh
        self.refreshExpires = refreshExpires
    }
}

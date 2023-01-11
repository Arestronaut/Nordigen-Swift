//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public final class StatusCodeResponse: Error, Codable {
    enum CodingKeys: String, CodingKey {
        case detail
        case summary
        case type
        case statusCode = "status_code"
    }
    
    public let detail: String
    public let summary: String
    public let type: String?
    public let statusCode: Int?
}

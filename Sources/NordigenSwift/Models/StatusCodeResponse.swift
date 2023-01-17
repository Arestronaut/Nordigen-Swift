//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct StatusCodeResponse: Error, Codable, Hashable, Equatable {
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

extension StatusCodeResponse: CustomStringConvertible {
    public var description: String {
        "- Detail: \(detail)\n- Summary: \(summary)\n- Type: \(String(describing: type))\n- StatusCode: \(String(describing: statusCode))"
    }
}

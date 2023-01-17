//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

enum DateFormatters {
    static let isoDateFormatter = ISO8601DateFormatter()
    static let simpleDateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.dateFormat = "YYYY-MM-DD"
        return result
    }()
}

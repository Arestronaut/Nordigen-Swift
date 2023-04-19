//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

enum DateFormatters {
    static let isoDateFormatter = ISO8601DateFormatter()
    static let simpleDateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.dateFormat = "yyyy-MM-dd"
        return result
    }()

    static let iso8601WithMilliseconds: DateFormatter = {
        let result = DateFormatter()
        result.calendar = .autoupdatingCurrent
        result.locale = .autoupdatingCurrent
        result.timeZone = .autoupdatingCurrent

        result.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"

        return result
    }()
}

//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

enum NumberFormatters {
    static let decimalNumberFormatterDotSeparated: NumberFormatter = {
        let result = NumberFormatter()
        result.numberStyle = .decimal
        result.generatesDecimalNumbers = true
        result.decimalSeparator = "."

        return result
    }()

    static let decimalNumberFormatterCommaSeparated: NumberFormatter = {
        let result = NumberFormatter()
        result.numberStyle = .decimal
        result.generatesDecimalNumbers = true
        result.decimalSeparator = ","

        return result
    }()
}

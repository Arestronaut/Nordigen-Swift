//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

enum NumberFormatters {
    static let decimalNumberFormatter: NumberFormatter = {
        let result = NumberFormatter()
        result.generatesDecimalNumbers = true
        result.decimalSeparator = ","
        result.minimumFractionDigits = 2
        result.maximumFractionDigits = 2
        return result
    }()

    static let currencyFormatter: NumberFormatter = {
        let result = NumberFormatter()
        result.numberStyle = .currency
        result.maximumFractionDigits = 2

        return result
    }()
}

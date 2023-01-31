//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

enum EquatableError: Error, Equatable {
    case error(Error)

    static func ==(lhs: Self, rhs: Self) -> Bool {
        guard case let .error(_lhs) = lhs, case let .error(_rhs) = rhs else { return false }
        guard type(of: lhs) == type(of: rhs) else { return false }
        let lhs = _lhs as NSError
        let rhs = _rhs as NSError

        return lhs.domain == rhs.domain && lhs.code == rhs.code && "\(lhs)" == "\(rhs)"
    }
}

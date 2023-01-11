//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

public enum NordigenError: LocalizedError {
    case preconditionError(message: String)

    public var errorDescription: String? {
        switch self {
        case let .preconditionError(message):
            return message
        }
    }
}

//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

extension Encodable {
    func toJSON() throws -> Data {
        try JSONEncoder().encode(self)
    }
}


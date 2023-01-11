//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public final class Paginated<T: Codable>: Codable {
    public let count: Int
    public let next: URL?
    public let previous: URL?
    public let results: [T]
}

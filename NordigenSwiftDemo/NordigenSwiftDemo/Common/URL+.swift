//
//  URL+.swift
//  NordigenSwiftDemo
//
//  Created by Raoul Schwagmeier on 16.01.23.
//

import Foundation

extension URL {
    func parsedQuery() -> [String: String] {
        guard let query = query() else { return [:] }
        let parameters = query.split(separator: "&").map(String.init)
        return parameters.reduce([String: String]()) { partialResult, substring in
            var partialResult = partialResult

            let keyValuePair = substring.split(separator: "=").map(String.init)
            guard keyValuePair.count == 2 else { return partialResult }
            partialResult[keyValuePair[0]] = keyValuePair[1]
            return partialResult
        }
    }
}

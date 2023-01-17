//
//  File.swift
//  
//
//  Created by Raoul Schwagmeier on 16.01.23.
//

import Foundation

extension URLRequest {
    var debugDescription: String {
        var body: String = "n/a"
        if let httpBody,
           let bodyString = String(data: httpBody, encoding: .utf8) {
            body = bodyString
        }

        return "🛰️ \(String(describing: url?.absoluteString))\n\t‣ Method \(String(describing: httpMethod))\n\t‣ Body:\(body)\n\t‣ Headers: \(String(describing: allHTTPHeaderFields))"
    }
}

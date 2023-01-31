//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

extension URLResponse {
    static func makeSuccessResponse() -> URLResponse {
        .makeResponse(statusCode: 200)
    }

    static func makeClientErrorResponse () -> URLResponse {
        .makeResponse(statusCode: 400)
    }

    private static func makeResponse(statusCode: Int) -> HTTPURLResponse {
        .init(url: URL(string: "test://")!, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public protocol TokenAPIProtocol: AnyObject {
    func new(secretId: String, secretKey: String) async throws -> AccessToken
    func refresh(token: String) async throws -> AccessToken
}

public final class TokenAPI: TokenAPIProtocol {
    private var endpoint: Endpoint
    
    internal init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    public func new(secretId: String, secretKey: String) async throws -> AccessToken {
        try await endpoint.post(
            path: "token/new/",
            input: ["secret_id": secretId, "secret_key": secretKey]
        )
    }
    
    public func refresh(token: String) async throws -> AccessToken {
        try await endpoint.post(
            path: "token/refresh/",
            input: ["refresh": token]
        )
    }
}

//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public final class NordigenClient {
    private var endpoint: Endpoint
    
    public let RequisitionsAPI: RequisitionsAPI
    public let TokenAPI: TokenAPI
    
    public init(endpoint: Endpoint = .init()) {
        self.endpoint = endpoint
        
        self.RequisitionsAPI = .init(endpoint: endpoint)
        self.TokenAPI = .init(endpoint: endpoint)
    }
    
    public func setAuthenticationToken(_ token: String?) {
        endpoint.setBearerToken(token)
    }
}

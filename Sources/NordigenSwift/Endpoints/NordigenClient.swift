//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public final class NordigenClient {
    private var endpoint: Endpoint

    public var AccountsAPI: AccountsAPIProtocol
    public var AgreementsAPI: AgreementsAPIProtocol
    public var InstitutionsAPI: InstitutionsAPIProtocol
    public var PaymentsAPI: PaymentsAPIProtocol
    public var RequisitionsAPI: RequisitionsAPIProtocol
    public var TokenAPI: TokenAPIProtocol
    
    public init(endpoint: Endpoint = .init()) {
        self.endpoint = endpoint

        self.AccountsAPI = NordigenSwift.AccountsAPI(endpoint: endpoint)
        self.AgreementsAPI = NordigenSwift.AgreementsAPI(endpoint: endpoint)
        self.InstitutionsAPI = NordigenSwift.InstitutionsAPI(endpoint: endpoint)
        self.PaymentsAPI = NordigenSwift.PaymentsAPI(endpoint: endpoint)
        self.RequisitionsAPI = NordigenSwift.RequisitionsAPI(endpoint: endpoint)
        self.TokenAPI = NordigenSwift.TokenAPI(endpoint: endpoint)
    }
    
    public func setAuthenticationToken(_ token: String?) {
        endpoint.setBearerToken(token)
    }
}

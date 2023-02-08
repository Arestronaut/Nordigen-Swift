//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public protocol InstitutionsAPIProtocol: AnyObject {
    func all(country: String, paymentsEnabled: Bool) async throws -> [Institution]
    func get(id: String) async throws -> Institution
}

public final class InstitutionsAPI: InstitutionsAPIProtocol {
    private var endpoint: Endpoint
    
    internal init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    public func all(country: String, paymentsEnabled: Bool) async throws -> [Institution] {
        guard !country.isEmpty else { throw NordigenError.preconditionError(message: "Provided `country` is empty") }
        // TODO: (Raoul 02/01/23) Check for valid iso3166 code
        
        return try await endpoint.get(
            path: "institutions/",
            queryParameters: [
                "country": country,
                "payments_enabled": paymentsEnabled.description
            ]
        )
    }
    
    public func get(id: String) async throws -> Institution {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.get(
            path: "institutions/\(id)/"
        )
    }
}

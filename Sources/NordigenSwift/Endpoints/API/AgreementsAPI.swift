//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public protocol AgreementsAPIProtocol: AnyObject {
    func all(limit: Int, offset: Int) async throws -> Paginated<EndUserAgreement>
    func create(_ payload: EndUserAgreementWriteRequest) async throws -> EndUserAgreement
    func get(id: String) async throws -> EndUserAgreement
    func delete(id: String) async throws -> EndUserAgreement
    func accept(id: String) async throws -> EndUserAgreementAcceptance
}

public final class AgreementsAPI: AgreementsAPIProtocol {
    private var endpoint: Endpoint
    
    internal init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    public func all(limit: Int, offset: Int) async throws -> Paginated<EndUserAgreement> {
        try await endpoint.get(
            path: "agreements/enduser/",
            queryParameters: [
                "limit": limit.description,
                "offset": offset.description
            ]
        )
    }
    
    public func create(_ payload: EndUserAgreementWriteRequest) async throws -> EndUserAgreement {
        if let maxHistoricalDays = payload.maxHistoricalDays, (1...730).contains(maxHistoricalDays) { throw NordigenError.preconditionError(message: "MaxHistoricalDays must been between 1 and 730") }
        if let accessValidForDays = payload.accessValidForDays, (1...730).contains(accessValidForDays) { throw NordigenError.preconditionError(message: "AccessValidForDays must be between 1 and 90") }

        return try await endpoint.post(
            path: "agreements/enduser/",
            input: payload
        )
    }
    
    public func get(id: String) async throws -> EndUserAgreement {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.get(
            path: "agreements/enduser/\(id)/"
        )
    }
    
    public func delete(id: String) async throws -> EndUserAgreement {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.delete(
            path: "agreements/enduser/\(id)/"
        )
    }
    
    public func accept(id: String) async throws -> EndUserAgreementAcceptance {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.put(path: "agreements/enduser/\(id)/")
    }
}

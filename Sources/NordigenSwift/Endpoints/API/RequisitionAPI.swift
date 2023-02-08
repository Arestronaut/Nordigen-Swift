//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public protocol RequisitionsAPIProtocol: AnyObject {
    func new(_ payload: RequisitionWriteRequest) async throws -> Requisition
    func all(limit: Int, offset: Int) async throws -> Paginated<Requisition>
    func get(id: String) async throws -> Requisition
    func delete(id: String) async throws
}

public final class RequisitionsAPI: RequisitionsAPIProtocol {
    private var endpoint: Endpoint
    
    internal init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    public func new(_ payload: RequisitionWriteRequest) async throws -> Requisition {
        try await endpoint.post(
            path: "requisitions/",
            input: payload
        )
    }
    
    public func all(limit: Int, offset: Int) async throws -> Paginated<Requisition> {
        try await endpoint.get(
            path: "requisitions/",
            queryParameters: [
                "limit": limit.description,
                "offset": offset.description
            ]
        )
    }
    
    public func get(id: String) async throws -> Requisition {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.get(path: "requisitions/\(id)/")
    }
    
    public func delete(id: String) async throws {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.delete(path: "requisitions/\(id)/")
    }
}

//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public final class AccountsAPI {
    private var endpoint: Endpoint
    
    internal init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    public func get(id: String) async throws -> Account {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.get(
            path: "accounts/\(id)/"
        )
    }
    
    public func balances(id: String) async throws -> BalancesResponse {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.get(
            path: "accounts/\(id)/balances"
        )
    }
    
    public func details(id: String) async throws -> AccountDetailResponse {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.get(
            path: "accounts/\(id)/details"
        )
    }
    
    public func transactions(id: String, from: Date, to: Date) async throws -> TransactionsResponse {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.get(
            path: "accounts/\(id)/transactions",
            queryParameters: [
                "from": DateFormatter.isoDateFormatter.string(from: from),
                "to": DateFormatter.isoDateFormatter.string(from: to)
            ]
        )
    }
    
    public func transactions(id: String, from: String, to: String) async throws -> TransactionsResponse {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        guard DateFormatter.isoDateFormatter.date(from: from) != nil else { throw NordigenError.preconditionError(message: "`from` is not in ISO8601 format") }
        guard DateFormatter.isoDateFormatter.date(from: to) != nil else { throw NordigenError.preconditionError(message: "`to` is not in ISO8601 format") }
        
        return try await endpoint.get(
            path: "accounts/\(id)/transactions",
            queryParameters: [
                "from": from,
                "to": to
            ]
        )
    }
}

//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public protocol AccountsAPIProtocol: AnyObject {
    func get(id: String) async throws -> Account
    func balances(id: String) async throws -> BalancesResponse
    func details(id: String) async throws -> AccountDetailResponse
    func transactions(id: String) async throws -> TransactionsResponse
    func transactions(id: String, from: Date, to: Date) async throws -> TransactionsResponse
    func transactions(id: String, from: String, to: String) async throws -> TransactionsResponse
}

public final class AccountsAPI: AccountsAPIProtocol {
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
            path: "accounts/\(id)/balances/"
        )
    }
    
    public func details(id: String) async throws -> AccountDetailResponse {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.get(
            path: "accounts/\(id)/details/"
        )
    }

    public func transactions(id: String) async throws -> TransactionsResponse {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }

        return try await endpoint.get(
            path: "accounts/\(id)/transactions/"
        )
    }

    public func transactions(id: String, from: Date, to: Date) async throws -> TransactionsResponse {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.get(
            path: "accounts/\(id)/transactions/",
            queryParameters: [
                "date_from": DateFormatters.simpleDateFormatter.string(from: from),
                "date_to": DateFormatters.simpleDateFormatter.string(from: to)
            ]
        )
    }
    
    public func transactions(id: String, from: String, to: String) async throws -> TransactionsResponse {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        guard DateFormatters.simpleDateFormatter.date(from: from) != nil else { throw NordigenError.preconditionError(message: "`from` is not correctly formatted: Use Format yyyy-MM-dd") }
        guard DateFormatters.simpleDateFormatter.date(from: to) != nil else { throw NordigenError.preconditionError(message: "`to` is not correctly formatted: Use Format yyyy-MM-dd") }
        
        return try await endpoint.get(
            path: "accounts/\(id)/transactions/",
            queryParameters: [
                "date_from": from,
                "date_to": to
            ]
        )
    }
}

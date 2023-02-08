//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

public protocol PaymentsAPIProtocol: AnyObject {
    func all(limit: Int, offset: Int) async throws -> Paginated<Payment>
    func new(_ payload: PaymentWriteRequest) async throws
    func get(id: String) async throws -> Payment
    func delete(id: String) async throws -> StatusCodeResponse
    func accounts() async throws -> [CreditorAccount]
    func creditors(
        account: String,
        addressCountry: String,
        agent: String,
        currency: String,
        name: String,
        type: AccountType,
        limit: Int,
        offset: Int) async throws -> Paginated<CreditorAccount>
    func newCreditor(_ payload: CreditorWriteRequest) async throws -> CreditorWriteResponse
    func creditor(id: String) async throws -> CreditorAccount
    func deleteCreditor(id: String) async throws
}

public final class PaymentsAPI: PaymentsAPIProtocol {
    private var endpoint: Endpoint
    
    internal init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    public func all(limit: Int, offset: Int) async throws -> Paginated<Payment> {
        try await endpoint.get(
            path: "payments/",
            queryParameters: [
                "limit": limit.description,
                "offset": offset.description
            ]
        )
    }
    
    public func new(_ payload: PaymentWriteRequest) async throws {
        // TODO: (Raoul 03/01/23) Create model PaymentRead
        try await endpoint.post(
            path: "payments/",
            input: payload
        )
    }
    
    public func get(id: String) async throws -> Payment {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.get(
            path: "payments/\(id)/"
        )
    }
    
    public func delete(id: String) async throws -> StatusCodeResponse {
        guard !id.isEmpty else { throw NordigenError.preconditionError(message: "Provided `id` is empty") }
        guard UUID(uuidString: id) != nil else { throw NordigenError.preconditionError(message: "Provided `id` is not a valid UUID") }
        
        return try await endpoint.delete(
            path: "payments/\(id)/"
        )
    }
    
    public func accounts() async throws -> [CreditorAccount] {
        try await endpoint.get(
            path: "payments/account/"
        )
    }
    
    public func creditors(
        account: String,
        addressCountry: String,
        agent: String,
        currency: String,
        name: String,
        type: AccountType,
        limit: Int,
        offset: Int) async throws -> Paginated<CreditorAccount> {
            // TODO: (Raoul 03/01/23) Validate input
            try await endpoint.get(
                path: "payments/creditors/",
                queryParameters: [
                    "account": account,
                    "address_country": addressCountry,
                    "agent": agent,
                    "currency": currency,
                    "name": name,
                    "type": type.rawValue,
                    "limit": limit.description,
                    "offset": offset.description
                ]
            )
        }

    public func newCreditor(_ payload: CreditorWriteRequest) async throws -> CreditorWriteResponse {
        try await endpoint.post(
            path: "payments/creditors/",
            input: payload
        )
    }

    public func creditor(id: String) async throws -> CreditorAccount {
        try await endpoint.get(
            path: "payments/creditors/\(id)/"
        )
    }

    public func deleteCreditor(id: String) async throws {
        try await endpoint.delete(
            path: "payments/creditors/\(id)/"
        )
    }
}

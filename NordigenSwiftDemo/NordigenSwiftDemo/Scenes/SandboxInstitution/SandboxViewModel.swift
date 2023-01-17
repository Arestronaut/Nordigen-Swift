//
//  SandboxViewModel.swift
//  NordigenSwiftDemo
//
//  Created by Raoul Schwagmeier on 16.01.23.
//

import NordigenSwift
import SwiftUI

@MainActor
final class SandboxViewModel: ObservableObject {
    @AppStorage(Constants.Keys.sandboxRequisition) private var sandboxRequisition: Requisition?

    @Published var account: Account?
    @Published var isLoadingAccount: Bool = false

    @Published var balances: [Balance] = []
    @Published var isLoadingBalances: Bool = false

    @Published var transactions: TransactionsResponse?
    @Published var isLoadingTransactions: Bool = false

    @Published var fromDate: Date = .init()
    @Published var toDate: Date = .init()

    private let nordigenClient: NordigenClient

    init(nordigenClient: NordigenClient) {
        self.nordigenClient = nordigenClient
    }

    func loadAccount() async {
        guard let sandboxRequisition, let accountId = sandboxRequisition.accounts.first else { return }
        isLoadingAccount = true

        do {
            account = try await nordigenClient.AccountsAPI.get(id: accountId)

            isLoadingAccount = false
        } catch {
            print(error)
            isLoadingAccount = false
        }
    }

    func loadBalances() async {
        guard let account else { return }

        isLoadingBalances = true
        do {
            balances = try await nordigenClient.AccountsAPI.balances(id: account.id).balances
            isLoadingBalances = false
        } catch {
            print(error)
            isLoadingBalances = false
        }
    }

    func loadTransactions() {
        guard let account else { return }

        Task {
            isLoadingTransactions = true

            do {
                transactions = try await nordigenClient.AccountsAPI.transactions(id: account.id, from: fromDate, to: toDate)
                isLoadingTransactions = false
            } catch {
                print(error)
                isLoadingTransactions = false
            }
        }
    }
}

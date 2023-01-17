//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct TransactionsResponse: Codable {
    struct BookedAndPendingTransactions: Codable {
        let booked: [Transaction]
        let pending: [Transaction]
    }

    private let transactions: BookedAndPendingTransactions

    public var booked: [Transaction] { transactions.booked }
    public var pending: [Transaction] { transactions.pending }

    init() {
        self.transactions = .init(booked: [], pending: [])
    }
}

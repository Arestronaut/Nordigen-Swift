//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct TransactionsResponse: Codable, Hashable, Equatable {
    public struct BookedAndPendingTransactions: Codable, Hashable, Equatable {
        public let booked: [Transaction]
        public let pending: [Transaction]

        public init(booked: [Transaction], pending: [Transaction]) {
            self.booked = booked
            self.pending = pending
        }
    }

    private let transactions: BookedAndPendingTransactions

    public var booked: [Transaction] { transactions.booked }
    public var pending: [Transaction] { transactions.pending }

    public init(transactions: BookedAndPendingTransactions) {
        self.transactions = transactions
    }
}

//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Transaction: Codable, Hashable, Equatable {
    public struct DebtorAccount: Codable, Hashable, Equatable {
        public let iban: String
        public init(iban: String) {
            self.iban = iban
        }
    }
    
    public let transactionId: String?
    public let debtorName: String?
    public let creditorName: String?
    public let debtorAccount: DebtorAccount?
    public let transactionAmount: MonetaryAmount
    public let bankTransactionCode: String?
    public let bookingDate: Date?
    public let valueDate: String
    public let remittanceInformationUnstructured: String?

    public init(transactionId: String?,
                creditorName: String?,
                debtorName: String?,
                debtorAccount: DebtorAccount?,
                transactionAmount: MonetaryAmount,
                bankTransactionCode: String?,
                merchantCategoryCode: String?,
                bookingDate: Date?,
                valueDate: String,
                remittanceInformationUnstructured: String?) {
        self.transactionId = transactionId
        self.creditorName = creditorName
        self.debtorName = debtorName
        self.debtorAccount = debtorAccount
        self.transactionAmount = transactionAmount
        self.bankTransactionCode = bankTransactionCode
        self.bookingDate = bookingDate
        self.valueDate = valueDate
        self.remittanceInformationUnstructured = remittanceInformationUnstructured
    }
}

//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Transaction: Codable {
    public struct DebtorAccount: Codable {
        public let iban: String
    }
    
    public let transactionId: String?
    public let debtorName: String?
    public let debtorAccount: DebtorAccount?
    public let transactionAmount: MonetaryAmount
    public let bankTransactionCode: String?
    public let bookingDate: String?
    public let valueDate: String
    public let remittanceInformationUnstructured: String
}

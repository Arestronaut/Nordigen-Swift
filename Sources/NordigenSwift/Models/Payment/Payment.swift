//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Payment: Codable, Hashable, Equatable {
    // MARK: - Subtypes
    public enum Status: String, Codable, Hashable, Equatable {
        case INIT
        case ERRE
        case ERRS
        case ACCC
        case ACCP
        case ACSC
        case ACSP
        case ACTC
        case ACWC
        case ACWP
        case RCVD
        case PDNG
        case RJCT
        case CANC
        case ACFC
        case PATC
        case PART
    }
    
    public enum Product: String, Codable, Hashable, Equatable {
        case T2P
        case SCT
        case ISCT
        case CBCT
    }
    
    public enum `Type`: String, Codable, Hashable, Equatable {
        case single = "single-payment"
        case bulk = "bulk-payment"
        case periodic = "periodic-payment"
    }
    
    public struct DebtorAccount: Codable, Hashable, Equatable {
        enum CodingKeys: String, CodingKey {
            case currency
            case account
            case type
            case name
            case addressCountry = "address_country"
            case postCode = "post_code"
            case addressStreet = "address_street"
        }
        
        public let currency: String
        public let account: String
        public let type: AccountType
        public let name: String
        public let addressCountry: String
        public let postCode: String
        public let addressStreet: String
    }
    
    enum CodingKeys: String, CodingKey {
        case paymentId = "payment_id"
        case paymentStatus = "payment_status"
        case paymentProduct = "payment_product"
        case paymentType = "payment_type"
        case redirect
        case description
        case customPaymentId = "custom_payment_id"
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case instructedAmount = "instructed_amount"
    }
    
    // MARK: - Public properties
    public let paymentId: String

    /// Payment end to end identification
    public let paymentStatus: Status

    /// Payment product
    public let paymentProduct: Product

    /// Payment Type
    public let paymentType: `Type`

    /// Redirect URL to your application after payment is done
    public let redirect: URL

    /// Payment description
    public let description: String

    /// Payment end to end identification
    public let customPaymentId: String

    /// Registered creditor account
    public let creditorAccount: String

    /// Debtor account
    public let debtorAccount: DebtorAccount

    /// Instructed amount
    public let instructedAmount: MonetaryAmount

    public init(paymentId: String, paymentStatus: Status, paymentProduct: Product, paymentType: Type, redirect: URL, description: String, customPaymentId: String, creditorAccount: String, debtorAccount: DebtorAccount, instructedAmount: MonetaryAmount) {
        self.paymentId = paymentId
        self.paymentStatus = paymentStatus
        self.paymentProduct = paymentProduct
        self.paymentType = paymentType
        self.redirect = redirect
        self.description = description
        self.customPaymentId = customPaymentId
        self.creditorAccount = creditorAccount
        self.debtorAccount = debtorAccount
        self.instructedAmount = instructedAmount
    }
}

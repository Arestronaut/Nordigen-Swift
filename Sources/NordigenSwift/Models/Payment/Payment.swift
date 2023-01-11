//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Payment: Codable {
    // MARK: - Subtypes
    public enum Status: String, Codable {
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
    
    public enum Product: String, Codable {
        case T2P
        case SCT
        case ISCT
        case CBCT
    }
    
    public enum `Type`: String, Codable {
        case single = "single-payment"
        case bulk = "bulk-payment"
        case periodic = "periodic-payment"
    }
    
    public struct DebtorAccount: Codable {
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
        case instructedAmount = "instructed_amount"
    }
    
    // MARK: - Public properties
    public let paymentId: String
    public let paymentStatus: Status
    public let paymentProduct: Product
    public let paymentType: `Type`
    public let redirect: URL
    public let description: String
    public let instructedAmount: MonetaryAmount
}

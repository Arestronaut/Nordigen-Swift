//
//  Copyright (c) Raoul Schwagmeier 2023.
//  MIT license, see LICENSE file for details
//

import Foundation

public struct PaymentWriteRequest: Codable, Hashable, Equatable {
    public struct PeriodicPayment: Codable, Hashable, Equatable {
        public enum Frequency: String, Codable, Hashable, Equatable {
            case daily = "Daily"
            case weekly = "Weekly"
            case everyTwoWeeks = "EveryTwoWeeks"
            case monthly = "Monthly"
            case everyTwoMonths = "EveryTwoMonths"
            case quarterly = "Quarterly"
            case semiAnnual = "SemiAnnual"
            case annual = "Annual"
            case monthlyVariable = "MonthlyVariable"
        }
        
        public enum ExecutionRule: String, Codable, Hashable, Equatable {
            case following
            case preceding
        }
        
        enum CodingKeys: String, CodingKey, Hashable, Equatable {
            case frequency
            case startDate = "start_date"
            case endDate = "end_date"
            case executionRule = "execution_rule"
            case dayOfExecution = "day_of_execution"
        }
        
        public let frequency: Frequency
        public let startDate: Date
        public let endDate: Date
        public let executionRule: ExecutionRule
        public let dayOfExecution: String
    }
    
    enum CodingKeys: String, CodingKey {
        case institutionId = "institution_id"
        case paymentProduct = "payment_product"
        case instructedAmount = "instructed_amount"
        case creditorAccount = "creditor_account"
        case debtorAccount = "debtor_account"
        case redirect
        case description
        case customPaymentId = "custom_payment_id"
        case requestedExecutionDate = "requested_execution_date"
        case periodicPayment = "periodic_payment"
    }
    
    // MARK: - Public properties
    public let institutionId: String
    public let paymentProduct: Payment.Product
    public let instructedAmount: MonetaryAmount
    public let creditorAccount: String
    public let debtorAccount: Payment.DebtorAccount
    public let redirect: URL
    public let description: String
    public let customPaymentId: String
    public let requestedExecutionDate: Date
    public let periodicPayment: PeriodicPayment
}

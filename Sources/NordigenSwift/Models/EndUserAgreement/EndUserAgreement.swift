//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct EndUserAgreement: Codable, Hashable, Equatable {
    public enum AccessScope: String, Codable, Hashable, Equatable {
        case balances
        case details
        case transactions
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case created
        case maxHistoricalDays = "max_historical_days"
        case accessValidForDays = "access_valid_for_days"
        case accessScope = "access_scope"
        case accepted
        case institutionId = "institution_id"
    }

    /// The ID of this End User Agreement, used to refer to this end user agreement in other API calls.
    public let id: String

    /// The date & time at which the end user agreement was created.
    public let created: Date

    /// Maximum number of days of transaction data to retrieve.
    public let maxHistoricalDays: Int

    /// Number of days from acceptance that the access can be used.
    public let accessValidForDays: Int

    /// Set containing one or several values of ['balances', 'details', 'transactions']
    public let accessScope: Set<AccessScope>

    /// The date & time at which the end user accepted the agreement.
    public let accepted: Date

    /// an Institution ID for this EUA
    public let institutionId: String

    public init(id: String, created: Date, maxHistoricalDays: Int, accessValidForDays: Int, accessScope: Set<AccessScope>, accepted: Date, institutionId: String) {
        self.id = id
        self.created = created
        self.maxHistoricalDays = maxHistoricalDays
        self.accessValidForDays = accessValidForDays
        self.accessScope = accessScope
        self.accepted = accepted
        self.institutionId = institutionId
    }
}

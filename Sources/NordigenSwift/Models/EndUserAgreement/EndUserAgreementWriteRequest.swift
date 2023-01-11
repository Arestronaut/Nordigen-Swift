//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct EndUserAgreementWriteRequest: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case id
        case created
        case maxHistoricalDays = "max_historical_days"
        case accessValidForDays = "access_valid_for_days"
        case accessScope = "access_scope"
        case accepted
        case institutionId = "institution_id"
    }
    
    let maxHistoricalDays: Int?
    let accessValidForDays: Int?
    let accessScope: Set<EndUserAgreement.AccessScope>?
    let institutionId: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        maxHistoricalDays = try container.decodeIfPresent(Int.self, forKey: .maxHistoricalDays)
        accessValidForDays = try container.decodeIfPresent(Int.self, forKey: .accessValidForDays)
        accessScope = try container.decodeIfPresent(Set<EndUserAgreement.AccessScope>.self, forKey: .accessScope)
        institutionId = try container.decode(String.self, forKey: .institutionId)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(maxHistoricalDays, forKey: .maxHistoricalDays)
        try container.encodeIfPresent(accessValidForDays, forKey: .accessValidForDays)
        try container.encodeIfPresent(accessScope, forKey: .accessScope)
        try container.encode(institutionId, forKey: .institutionId)
    }
}

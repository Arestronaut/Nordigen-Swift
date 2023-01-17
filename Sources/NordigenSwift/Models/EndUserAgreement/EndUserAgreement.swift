//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct EndUserAgreement: Codable, Equatable {
    enum AccessScope: String, Codable {
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
    
    let id: String
    let created: Date
    let maxHistoricalDays: Int
    let accessValidForDays: Int
    let accessScope: Set<AccessScope>
    let accepted: Date
    let institutionId: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        
        if let _created = DateFormatters.isoDateFormatter.date(from: try container.decode(String.self, forKey: .created)) {
            self.created = _created
        } else {
            preconditionFailure("`Created` couldn't be created. It might be the wrong format.")
        }
        
        maxHistoricalDays = try container.decode(Int.self, forKey: .maxHistoricalDays)
        accessValidForDays = try container.decode(Int.self, forKey: .accessValidForDays)
        accessScope = try container.decode(Set<AccessScope>.self, forKey: .accessScope)
        
        if let _accepted = DateFormatters.isoDateFormatter.date(from: try container.decode(String.self, forKey: .id)) {
            self.accepted = _accepted
        } else {
            preconditionFailure("`Accepted` couldn't be created. It might be the wrong format.")
        }
        
        institutionId = try container.decode(String.self, forKey: .institutionId)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        
        let createdString = DateFormatters.isoDateFormatter.string(from: self.created)
        try container.encode(createdString, forKey: .created)
        
        try container.encode(maxHistoricalDays, forKey: .maxHistoricalDays)
        try container.encode(accessValidForDays, forKey: .accessValidForDays)
        try container.encode(accessScope, forKey: .accessScope)
        
        let acceptedString = DateFormatters.isoDateFormatter.string(from: accepted)
        try container.encode(acceptedString, forKey: .accepted)
        
        try container.encode(institutionId, forKey: .institutionId)
    }
}

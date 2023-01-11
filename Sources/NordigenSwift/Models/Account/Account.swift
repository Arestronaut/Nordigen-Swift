//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public final class Account: Codable {
    enum Status: String {
        case discovered
        case processing
        case error
        case expired
        case ready
        case suspend
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case created
        case lastAccessed = "last_accessed"
        case iban
        case institutionId = "institution_id"
        case status
        case ownerName = "owner_name"
    }
    
    let id: String
    let created: String
    let lastAccessed: String
    let iban: String
    let institutionId: String
    let status: (Status, String)?
    let ownerName: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.created = try container.decode(String.self, forKey: .created)
        self.lastAccessed = try container.decode(String.self, forKey: .lastAccessed)
        self.iban = try container.decode(String.self, forKey: .iban)
        self.institutionId = try container.decode(String.self, forKey: .institutionId)
        self.ownerName = try container.decode(String.self, forKey: .ownerName)
        
        if
            let _statusString = try container.decodeIfPresent(String.self, forKey: .status),
            let _status = try? JSONSerialization.jsonObject(with: _statusString.data(using: .utf8)!) as? [String: String],
            let statusKey = _status.keys.first?.lowercased(),
            let status = Status(rawValue: statusKey),
            let value = _status[statusKey]
        {
            self.status = (status, value)
        } else {
            self.status = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(created, forKey: .created)
        try container.encode(lastAccessed, forKey: .lastAccessed)
        try container.encode(iban, forKey: .iban)
        try container.encode(institutionId, forKey: .institutionId)
        
        if let status {
            try container.encode([status.0.rawValue.uppercased(): status.1], forKey: .status)
        }
    }
}


//
//  Copyright (c) Raoul Schwagmeier 2023
//  MIT license, see LICENSE file for details
//

import Foundation

public struct Account: Codable, Hashable, Equatable {
    public enum Status: String, Hashable, Equatable {
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
    
    public let id: String
    public let created: String
    public let lastAccessed: String
    public let iban: String
    public let institutionId: String
    public let status: (Status, String)?
    public let ownerName: String
    
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

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(created)
        hasher.combine(lastAccessed)
        hasher.combine(iban)
        hasher.combine(institutionId)
        if let status {
            hasher.combine(status.0)
            hasher.combine(status.1)
        }
    }

    public static func ==(lhs: Account, rhs: Account) -> Bool {
        lhs.id == rhs.id &&
        lhs.created == rhs.created &&
        lhs.lastAccessed == rhs.lastAccessed &&
        lhs.iban == rhs.iban &&
        lhs.institutionId == rhs.institutionId &&
        lhs.status?.0 == rhs.status?.0 &&
        lhs.status?.1 == rhs.status?.1
    }
}


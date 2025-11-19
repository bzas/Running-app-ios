//
//  UserDataModel.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain
import Foundation

public struct UserDataModel: Sendable {
    
    public var name: String?
    public var age: String?
    public var maxHeartRate: Int?
    public var heartRateZones: [HeartRateZoneDataModel]
    
    public init(
        name: String?,
        age: String?,
        maxHeartRate: UInt8?,
        heartRateZones: [HeartRateZoneDataModel]
    ) {
        self.name = name
        self.age = age
        self.heartRateZones = heartRateZones
        
        if let maxHeartRate {
            self.maxHeartRate = Int(maxHeartRate)
        }
    }
}

// MARK: - Convert to Domain object

extension UserDataModel {
    
    func toDomain() -> User {
        User(
            name: name ?? "",
            age: age ?? "",
            maxHeartRate: maxHeartRate,
            heartRateZones: heartRateZones.map { $0.toDomain() }
        )
    }
}

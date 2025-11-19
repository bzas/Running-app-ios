//
//  HeartRateZoneDataModel.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain
import Foundation

public struct HeartRateZoneDataModel: Sendable {
    
    public let zoneNumber: Int
    public var minHeartRate: Int
    public var maxHeartRate: Int
    
    public init(
        zoneNumber: Int,
        minHeartRate: Int,
        maxHeartRate: Int
    ) {
        self.zoneNumber = zoneNumber
        self.minHeartRate = minHeartRate
        self.maxHeartRate = maxHeartRate
    }
}

// MARK: - Convert to Domain object

extension HeartRateZoneDataModel {
    
    func toDomain() -> HeartRateZone {
        HeartRateZone(
            zoneNumber: zoneNumber,
            minHeartRate: minHeartRate,
            maxHeartRate: maxHeartRate
        )
    }
}

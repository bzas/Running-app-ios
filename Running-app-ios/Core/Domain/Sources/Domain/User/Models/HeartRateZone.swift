//
//  HeartRateZone.swift
//  Domain
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Foundation

public struct HeartRateZone: Identifiable, Sendable {
    
    public let id = UUID()
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

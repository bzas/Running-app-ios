//
//  SessionHeartRateZone.swift
//  Domain
//
//  Created by Alfonso Boizas Crespo on 24/11/25.
//

import Foundation

public struct SessionHeartRateZone: Identifiable, Sendable {
    
    public let id: UUID
    public let zoneNumber: Int
    public let percentageInZone: Double
    public var lowerLimit: Int?
    public var upperLimit: Int?
    
    public init(
        id: UUID = UUID(),
        zoneNumber: Int,
        unitsInZone: Int,
        totalUnits: Int,
        lowerLimit: Int,
        upperLimit: Int
    ) {
        self.id = id
        self.zoneNumber = zoneNumber
        self.percentageInZone = Double(unitsInZone) / Double(totalUnits)
        
        if lowerLimit > 0 {
            self.lowerLimit = lowerLimit
        }
        
        if upperLimit < 250 {
            self.upperLimit = upperLimit
        }
    }
}

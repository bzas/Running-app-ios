//
//  User.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import Foundation

public struct User: Identifiable, Sendable {
    
    public let id = UUID()
    public var name: String
    public var age: Int
    public var maxHeartRate: Int
    public var heartRateZones: [HeartRateZone] = []
    
    public init(
        name: String,
        age: Int,
        maxHeartRate: Int
    ) {
        self.name = name
        self.age = age
        self.maxHeartRate = maxHeartRate
        self.heartRateZones = createHeartRateZones(maxHeartRate)
    }
}

// MARK: - Aux methods

extension User {
    
    func createHeartRateZones(_ maxHeartRate: Int) -> [HeartRateZone] {
        let percentages: [Double] = [0.65, 0.82, 0.90, 0.95]
        let limits = percentages.map { Int(Double(maxHeartRate) * $0) }
        let boundaries = zip([0] + limits, limits + [250])

        return boundaries.enumerated().map { index, pair in
            HeartRateZone(
                zoneNumber: index + 1,
                minHeartRate: pair.0,
                maxHeartRate: pair.1
            )
        }
    }
}

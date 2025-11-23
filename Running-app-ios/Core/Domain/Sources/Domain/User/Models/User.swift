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
    public var age: String
    public var maxHeartRate: Int
    public var heartRateZones: [HeartRateZone] = []
    
    public init(
        name: String,
        age: String,
        maxHeartRate: Int
    ) {
        self.name = name
        self.age = age
        self.maxHeartRate = maxHeartRate
        self.heartRateZones = createHeartRateZones()
    }
}

// MARK: - Aux methods

extension User {
    
    func createHeartRateZones() -> [HeartRateZone] {
        []
    }
}

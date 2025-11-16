//
//  WorkoutSessionTrackPointDataModel.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 13/11/25.
//

import Domain
import Foundation

public struct WorkoutSessionTrackPointDataModel: Sendable {
    
    public var latitude: Double?
    public var longitude: Double?
    public var altitude: Double?
    public var distance: Double
    public var heartRate: Int?
    public var timestamp: Date
    
    public init?(
        latitude: Double?,
        longitude: Double?,
        altitude: Double?,
        distance: Double?,
        heartRate: UInt8?,
        timestamp: Date?
    ) {
        guard let distance,
              let timestamp else { return nil }
        
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.distance = distance
        self.timestamp = timestamp
        if let heartRate {
            self.heartRate = Int(heartRate)
        }
    }
}

// MARK: - Convert to Domain object

public extension WorkoutSessionTrackPointDataModel {
    
    func toDomain() -> WorkoutSessionTrackPoint? {
        guard let latitude,
              let longitude else { return nil }
        
        return WorkoutSessionTrackPoint(
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            distance: distance,
            heartRate: heartRate,
            timestamp: timestamp
        )
    }
}

//
//  WorkoutSessionTrackPoint.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation

public struct WorkoutSessionTrackPoint: Sendable {
    
    public var latitude: Double
    public var longitude: Double
    public var altitude: Double?
    public var distance: Double
    public var heartRate: Int?
    public var timestamp: Date
    
    public init(
        latitude: Double,
        longitude: Double,
        altitude: Double?,
        distance: Double,
        heartRate: Int?,
        timestamp: Date
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.distance = distance
        self.heartRate = heartRate
        self.timestamp = timestamp
    }
}

extension WorkoutSessionTrackPoint {
    
    static func secondsBetween(
        previous: WorkoutSessionTrackPoint,
        current: WorkoutSessionTrackPoint
    ) -> Double {
        current.timestamp.timeIntervalSince(previous.timestamp)
    }
}

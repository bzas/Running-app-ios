//
//  WorkoutSessionTrackPoint.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation
import MapKit

public struct WorkoutSessionTrackPoint: Identifiable, Sendable {
    
    public let id: UUID
    public var locationPoint: CLLocationCoordinate2D
    public var altitude: Double?
    public var distance: Double
    public var heartRate: Int?
    public var timestamp: Date?
    
    public init(
        id: UUID = UUID(),
        latitude: Double,
        longitude: Double,
        altitude: Double?,
        distance: Double,
        heartRate: Int?,
        timestamp: Date?
    ) {
        self.id = id
        self.locationPoint = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
        self.altitude = altitude
        self.distance = distance
        self.heartRate = heartRate
        self.timestamp = timestamp
    }
}

// MARK: - Aux methods

extension WorkoutSessionTrackPoint {
    
    static func secondsBetween(
        previous: WorkoutSessionTrackPoint,
        current: WorkoutSessionTrackPoint
    ) -> Double {
        guard let currentTimestamp = current.timestamp,
              let previousTimestamp = previous.timestamp else {
            return 0
        }
        
        return currentTimestamp.timeIntervalSince(previousTimestamp)
    }
}

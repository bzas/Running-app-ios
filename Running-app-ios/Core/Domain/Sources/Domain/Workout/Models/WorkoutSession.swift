//
//  WorkoutSession.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation

public struct WorkoutSession: Identifiable, Sendable {
    
    public let id = UUID()
    public var name: String
    public var timestamp: Date?
    public var heartRate: Int?
    public var cadence: Int?
    public var speed: Double
    public var distance: Double
    public var totalTime: Double
    public var latitude: Double?
    public var longitude: Double?
    public var sessionTrackPoints: [WorkoutSessionTrackPoint]
    
    public var distanceInKm: Double {
        distance / 1000.0
    }

    public var paceInSeconds: Double {
        guard speed <= 0 else {
            return 1000.0 / speed
        }
        
        guard distanceInKm > 0 else { return 0 }
        return totalTime / distanceInKm
    }
    
    public init(
        name: String,
        timestamp: Date?,
        heartRate: Int?,
        cadence: Int?,
        speed: Double,
        distance: Double,
        totalTime: Double,
        latitude: Double?,
        longitude: Double?,
        sessionTrackPoints: [WorkoutSessionTrackPoint]
    ) {
        self.name = name
        self.timestamp = timestamp
        self.heartRate = heartRate
        self.cadence = cadence
        self.speed = speed
        self.distance = distance
        self.totalTime = totalTime
        self.latitude = latitude
        self.longitude = longitude
        self.sessionTrackPoints = sessionTrackPoints
    }
}

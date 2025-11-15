//
//  WorkoutSessionDataModel.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import Foundation
import Domain

public struct WorkoutSessionDataModel: Identifiable, Sendable {
    
    public let id = UUID()
    public var name: String?
    public var timestamp: Date?
    public var heartRate: Int?
    public var cadence: Int?
    public var speed: Double?
    public var distance: Double?
    public var totalTime: Double?
    public var latitude: Double?
    public var longitude: Double?
    public var sessionTrackPoints: [WorkoutSessionTrackPointDataModel]
    
    public init(
        name: String?,
        timestamp: Date?,
        heartRate: UInt8?,
        cadence: UInt8?,
        speed: Double?,
        distance: Double?,
        totalTime: Double?,
        latitude: Double?,
        longitude: Double?,
        sessionTrackPoints: [WorkoutSessionTrackPointDataModel]
    ) {
        self.name = name
        self.timestamp = timestamp
        
        if let heartRate {
            self.heartRate = Int(heartRate)
        }
        if let cadence {
            self.cadence = Int(cadence)
        }
        
        self.speed = speed
        self.distance = distance
        self.totalTime = totalTime
        self.latitude = latitude
        self.longitude = longitude
        self.sessionTrackPoints = sessionTrackPoints
    }
}

// MARK: - Convert to Domain object

public extension WorkoutSessionDataModel {
    
    func toDomain() -> WorkoutSession {
        return WorkoutSession(
            name: name ?? "",
            timestamp: timestamp,
            heartRate: heartRate,
            cadence: cadence,
            speed: speed ?? 0,
            distance: distance ?? 0,
            totalTime: totalTime ?? 0,
            latitude: latitude,
            longitude: longitude,
            sessionTrackPoints: sessionTrackPoints.compactMap { $0.toDomain() }
        )
    }
}

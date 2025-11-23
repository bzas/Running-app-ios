//
//  WorkoutSessionTrackPointDataModel.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 13/11/25.
//

import Domain
import Foundation
import SwiftData

@Model
public final class WorkoutSessionTrackPointDataModel {
    
    public var id: UUID
    public var latitude: Double?
    public var longitude: Double?
    public var altitude: Double?
    public var distance: Double
    public var heartRate: Int?
    public var timestamp: Date
    
    public init(
        id: UUID,
        latitude: Double?,
        longitude: Double?,
        altitude: Double?,
        distance: Double,
        heartRate: Int?,
        timestamp: Date
    ) {
        self.id = id
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.distance = distance
        self.timestamp = timestamp
        self.heartRate = heartRate
    }
    
    convenience init(from domain: WorkoutSessionTrackPoint?) throws {
        guard let domain,
              let timestamp = domain.timestamp else {
            throw DatabaseError.trackPointDataError
        }
        
        self.init(
            id: domain.id,
            latitude: domain.locationPoint.latitude,
            longitude: domain.locationPoint.longitude,
            altitude: domain.altitude,
            distance: domain.distance,
            heartRate: domain.heartRate,
            timestamp: timestamp
        )
    }
}

// MARK: - Convert to Domain object

public extension WorkoutSessionTrackPointDataModel {
    
    func toDomain() throws -> WorkoutSessionTrackPoint {
        guard let latitude,
              let longitude else {
            throw DatabaseError.trackPointDataError
        }
        
        return WorkoutSessionTrackPoint(
            id: id,
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            distance: distance,
            heartRate: heartRate,
            timestamp: timestamp
        )
    }
}

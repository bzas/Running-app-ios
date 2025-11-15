//
//  WorkoutSessionTrackPointDataModel.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 13/11/25.
//

import Domain

public struct WorkoutSessionTrackPointDataModel: Sendable {
    
    public var latitude: Double?
    public var longitude: Double?
    public var altitude: Double?
    
    public init(
        latitude: Double?,
        longitude: Double?,
        altitude: Double?
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
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
            altitude: altitude
        )
    }
}

//
//  WorkoutSessionTrackPointDataModel.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 13/11/25.
//

import Domain

public struct WorkoutSessionTrackPointDataModel: Sendable {
    
    public var latitude: Int?
    public var longitude: Int?
    public var altitude: Double?
    
    public init(
        latitude: Int32?,
        longitude: Int32?,
        altitude: Double?
    ) {
        if let latitude {
            self.latitude = Int(latitude)
        }
        if let longitude {
            self.longitude = Int(longitude)
        }
        self.altitude = altitude
    }
}

// MARK: - Convert to Domain object

public extension WorkoutSessionTrackPointDataModel {
    
    func toDomain() -> WorkoutSessionTrackPoint {
        WorkoutSessionTrackPoint(
            latitude: latitude ?? 0,
            longitude: longitude ?? 0,
            altitude: altitude ?? 0
        )
    }
}

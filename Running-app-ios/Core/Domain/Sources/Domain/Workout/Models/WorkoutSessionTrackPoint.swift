//
//  WorkoutSessionTrackPoint.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

public struct WorkoutSessionTrackPoint: Sendable {
    
    public var latitude: Int
    public var longitude: Int
    public var altitude: Double
    
    public init(
        latitude: Int,
        longitude: Int,
        altitude: Double
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
    }
}

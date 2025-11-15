//
//  WorkoutSessionTrackPoint.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

public struct WorkoutSessionTrackPoint: Sendable {
    
    public var latitude: Double
    public var longitude: Double
    public var altitude: Double?
    
    public init(
        latitude: Double,
        longitude: Double,
        altitude: Double?
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
    }
}

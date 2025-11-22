//
//  GarminWorkoutSessionTrackPointDTO+Factory.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import Domain

extension GarminWorkoutSessionTrackPointDTO {
    
    func toDomain() throws -> WorkoutSessionTrackPoint {
        guard let latitude,
              let longitude,
              let distance else {
            throw GarminError.trackPointLocalizationError
        }
        
        var domainHeartRate: Int?
        if let heartRate {
            domainHeartRate = Int(exactly: heartRate)
        }
        
        return WorkoutSessionTrackPoint(
            latitude: latitude,
            longitude: longitude,
            altitude: altitude,
            distance: distance,
            heartRate: domainHeartRate,
            timestamp: timestamp
        )
    }
}

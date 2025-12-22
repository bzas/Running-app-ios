//
//  GarminWorkoutSessionDTO+Factory.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import Domain

extension GarminWorkoutSessionDTO {
    
    func toDomain() -> WorkoutSession {
        var domainHeartRate: Int?
        if let heartRate {
            domainHeartRate = Int(exactly: heartRate)
        }
        
        var domainMaxHeartRate: Int?
        if let maxHeartRate {
            domainMaxHeartRate = Int(exactly: maxHeartRate)
        }
        
        var domainMinHeartRate: Int?
        if let minHeartRate {
            domainMinHeartRate = Int(exactly: minHeartRate)
        }
        
        var domainCadence: Int?
        if let cadence,
           let cadenceInt = Int(exactly: cadence)  {
            domainCadence = cadenceInt * 2
        }
        
        var domainGCT: Int?
        if let stanceTime {
            domainGCT = Int(stanceTime)
        }
        
        return WorkoutSession(
            timestamp: timestamp,
            heartRate: domainHeartRate,
            maxHeartRate: domainMaxHeartRate,
            minHeartRate: domainMinHeartRate,
            cadence: domainCadence,
            speed: speed ?? 0,
            distance: distance ?? 0,
            totalTime: totalTime ?? 0,
            sessionTrackPoints: sessionTrackPoints.compactMap { try? $0.toDomain() },
            photos: [],
            verticalOscillation: verticalRatio,
            groundContactTime: domainGCT
        )
    }
}

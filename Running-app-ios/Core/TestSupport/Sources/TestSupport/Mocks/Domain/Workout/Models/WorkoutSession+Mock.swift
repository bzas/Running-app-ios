//
//  WorkoutSession+Mock.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation
import Domain

public extension WorkoutSession {
    
    static var mock: WorkoutSession {
        WorkoutSession(
            timestamp: Date(timeIntervalSince1970: 1000),
            heartRate: 145,
            maxHeartRate: 190,
            minHeartRate: 120,
            cadence: 165,
            speed: 3.8,
            distance: 10_000,
            totalTime: 2_700,
            sessionTrackPoints: [.mock],
            photos: [SessionPhoto(data: Data("test-photo".utf8))],
            verticalOscillation: 8.2,
            groundContactTime: 250
        )
    }
}

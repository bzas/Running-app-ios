//
//  WorkoutSessionDataModel+Mock.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Foundation
@testable import Database

extension WorkoutSessionDataModel {
    
    static var mock: WorkoutSessionDataModel {
        WorkoutSessionDataModel(
            id: UUID(),
            timestamp: Date(timeIntervalSince1970: 1000),
            heartRate: 145,
            maxHeartRate: 190,
            minHeartRate: 120,
            cadence: 165,
            speed: 3.8,
            distance: 10_000,
            totalTime: 2_700,
            latitude: 40.4168,
            longitude: -3.7038,
            sessionTrackPoints: [.mock],
            photos: [.mock],
            verticalOscillation: 8.2,
            groundContactTime: 250
        )
    }
}

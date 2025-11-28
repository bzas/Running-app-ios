//
//  WorkoutSessionTrackPoint+Mock.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Domain
import Foundation

public extension WorkoutSessionTrackPoint {
    
    static var mock: WorkoutSessionTrackPoint {
        WorkoutSessionTrackPoint(
            latitude: 40.4168,
            longitude: -3.7038,
            altitude: 650,
            distance: 0,
            heartRate: 145,
            timestamp: Date(timeIntervalSince1970: 1000),
            cadence: 165
        )
    }
}

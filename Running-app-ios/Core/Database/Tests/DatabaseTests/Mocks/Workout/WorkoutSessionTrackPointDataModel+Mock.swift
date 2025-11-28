//
//  WorkoutSessionTrackPointDataModel+Mock.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

@testable import Database
import Foundation

extension WorkoutSessionTrackPointDataModel {
    
    static var mock: WorkoutSessionTrackPointDataModel {
        WorkoutSessionTrackPointDataModel(
            id: UUID(),
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

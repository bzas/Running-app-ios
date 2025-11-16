//
//  WorkoutSessionDataModel+Factory.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 15/11/25.
//

import Database
import FITSwiftSDK

extension WorkoutSessionDataModel {
    
    init?(listener: FitListener) {
        guard let garminSession = listener.fitMessages.sessionMesgs.first else {
            return nil
        }
        
        let garminMapPoints = listener.fitMessages.recordMesgs.compactMap { record in
            WorkoutSessionTrackPointDataModel(record: record)
        }
        
        self.init(
            timestamp: garminSession.getTimestamp()?.date,
            heartRate: garminSession.getAvgHeartRate(),
            maxHeartRate: garminSession.getMaxHeartRate(),
            minHeartRate: garminSession.getMinHeartRate(),
            cadence: garminSession.getAvgCadence(),
            speed: garminSession.getAvgSpeed(),
            distance: garminSession.getTotalDistance(),
            totalTime: garminSession.getTotalTimerTime(),
            latitude: toDegrees(garminSession.getSwcLat()),
            longitude: toDegrees(garminSession.getSwcLong()),
            sessionTrackPoints: garminMapPoints
        )
    }
}

func toDegrees(_ semicircles: Int32?) -> Double? {
    guard let semicircles else { return nil }
    return Double(semicircles) * (180.0 / Double(1 << 31))
}

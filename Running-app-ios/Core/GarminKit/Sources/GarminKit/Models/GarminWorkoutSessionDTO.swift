//
//  WorkoutSessionDTO.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import FITSwiftSDK
import Foundation

final class GarminWorkoutSessionDTO {
    
    var timestamp: Date?
    var heartRate: UInt8?
    var maxHeartRate: UInt8?
    var minHeartRate: UInt8?
    var cadence: UInt8?
    var speed: Double?
    var distance: Double?
    var totalTime: Double?
    var latitude: Double?
    var longitude: Double?
    var verticalRatio: Double?
    var stanceTime: Double?
    var sessionTrackPoints: [GarminWorkoutSessionTrackPointDTO]
    
    init(
        timestamp: Date?,
        heartRate: UInt8?,
        maxHeartRate: UInt8?,
        minHeartRate: UInt8?,
        cadence: UInt8?,
        speed: Double?,
        distance: Double?,
        totalTime: Double?,
        latitude: Double?,
        longitude: Double?,
        verticalRatio: Double?,
        stanceTime: Double?,
        sessionTrackPoints: [GarminWorkoutSessionTrackPointDTO]
    ) {
        self.timestamp = timestamp
        self.heartRate = heartRate
        self.maxHeartRate = maxHeartRate
        self.minHeartRate = minHeartRate
        self.cadence = cadence
        self.speed = speed
        self.distance = distance
        self.totalTime = totalTime
        self.latitude = latitude
        self.longitude = longitude
        self.verticalRatio = verticalRatio
        self.stanceTime = stanceTime
        self.sessionTrackPoints = sessionTrackPoints
    }
    
    convenience init(listener: FitListener) throws {
        guard let garminSession = listener.fitMessages.sessionMesgs.first else {
            throw GarminError.missingSessionMessageError
        }
        
        let garminMapPoints = listener.fitMessages.recordMesgs.compactMap { record in
            GarminWorkoutSessionTrackPointDTO(record: record)
        }
        
        self.init(
            timestamp: garminSession.getTimestamp()?.date,
            heartRate: garminSession.getAvgHeartRate(),
            maxHeartRate: garminSession.getMaxHeartRate(),
            minHeartRate: garminSession.getMinHeartRate(),
            cadence: garminSession.getAvgCadence(),
            speed: garminSession.getAvgSpeed(),
            distance: garminSession.getTotalDistance(),
            totalTime: garminSession.getTotalElapsedTime(),
            latitude: toDegrees(garminSession.getSwcLat()),
            longitude: toDegrees(garminSession.getSwcLong()),
            verticalRatio: garminSession.getAvgVerticalRatio(),
            stanceTime: garminSession.getAvgStanceTime(),
            sessionTrackPoints: garminMapPoints
        )
    }
}

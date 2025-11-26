//
//  WorkoutSessionTrackPointDTO.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import FITSwiftSDK
import Foundation

final class GarminWorkoutSessionTrackPointDTO {
    
    var latitude: Double?
    var longitude: Double?
    var altitude: Double?
    var distance: Double?
    var heartRate: UInt8?
    var timestamp: Date?
    var cadence: UInt8?
    
    init(
        latitude: Double?,
        longitude: Double?,
        altitude: Double?,
        distance: Double?,
        heartRate: UInt8?,
        timestamp: Date?,
        cadence: UInt8?
    ) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.distance = distance
        self.heartRate = heartRate
        self.timestamp = timestamp
        self.cadence = cadence
    }
    
    convenience init?(record: RecordMesg) {
        self.init(
            latitude: toDegrees(record.getPositionLat()),
            longitude: toDegrees(record.getPositionLong()),
            altitude: record.getEnhancedAltitude() ?? record.getAltitude(),
            distance: record.getDistance(),
            heartRate: record.getHeartRate(),
            timestamp: record.getTimestamp()?.date,
            cadence: record.getCadence()
        )
    }
}

func toDegrees(_ semicircles: Int32?) -> Double? {
    guard let semicircles else { return nil }
    return Double(semicircles) * (180.0 / Double(1 << 31))
}

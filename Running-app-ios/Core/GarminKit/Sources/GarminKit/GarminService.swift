//
//  GarminService.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Database
import Foundation
import FITSwiftSDK

public actor GarminService: GarminServiceProtocol {
    
    public init() {}
    
    public func fetchFitFile(from data: Data) async throws -> WorkoutSessionDataModel? {
        let stream = FITSwiftSDK.InputStream(data: data)
        let decoder = Decoder(stream: stream)
        let garminListener = FitListener()
        decoder.addMesgListener(garminListener)
        try decoder.read();
                
        guard let garminSession = garminListener.fitMessages.sessionMesgs.first else {
            return nil
        }
        
        let garminMapPoints = garminListener.fitMessages.recordMesgs.map { record in
            WorkoutSessionTrackPointDataModel(
                latitude: record.getPositionLat(),
                longitude: record.getPositionLong(),
                altitude: record.getAltitude()
            )
        }

        return WorkoutSessionDataModel(
            name: garminSession.getSportProfileName(),
            timestamp: garminSession.getTimestamp()?.date,
            heartRate: garminSession.getAvgHeartRate(),
            cadence: garminSession.getAvgCadence(),
            speed: garminSession.getAvgSpeed(),
            distance: garminSession.getTotalDistance(),
            totalTime: garminSession.getTotalTimerTime(),
            sessionTrackPoints: garminMapPoints
        )
    }
}

//
//  WorkoutSessionTrackPointDataModel+Factory.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 15/11/25.
//

import Database
import FITSwiftSDK

extension WorkoutSessionTrackPointDataModel {
    
    init(record: RecordMesg) {
        self.init(
            latitude: toDegrees(record.getPositionLat()),
            longitude: toDegrees(record.getPositionLong()),
            altitude: record.getAltitude()
        )
    }
}

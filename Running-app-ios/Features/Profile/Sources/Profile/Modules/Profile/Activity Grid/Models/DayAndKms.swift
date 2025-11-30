//
//  DayAndKms.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import Foundation
import Domain

struct DayAndKms {
    
    let id: UUID
    let day: Int
    let kms: Double
    
    init(
        id: UUID,
        day: Int,
        kms: Double
    ) {
        self.id = id
        self.day = day
        self.kms = kms
    }
    
    init?(session: WorkoutSession) {
        guard session.timestamp?.isInCurrentYear == true else { return nil }
        
        self.init(
            id: session.id,
            day: session.timestamp?.dayOfYear ?? 0,
            kms: session.distanceInKm
        )
    }
}

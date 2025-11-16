//
//  WorkoutFormatter.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import Domain

class WorkoutFormatter {
    
    static func pace(seconds: Double) -> String {
        guard seconds > 0 else { return "--:--" }
        
        let m = Int(seconds) / 60
        let s = Int(seconds) % 60
        return "\(m):\(String(format: "%02d", s)) /km"
    }
    
    static func pace(session: WorkoutSession) -> String {
        pace(seconds: session.paceInSeconds)
    }
    
    static func distance(session: WorkoutSession) -> String {
        String(format: "%.2f km", session.distanceInKm)
    }
    
    static func time(session: WorkoutSession) -> String {
        let totalSeconds = Int(session.totalTime)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60

        switch (hours, minutes) {
        case (0, _):
            return "\(minutes)min"
        case (_, 0):
            return "\(hours)h"
        default:
            return "\(hours)h \(minutes)min"
        }
    }
    
    static func heartRate(_ heartRate: Int?) -> String {
        guard let heartRate else { return "- bpm" }
        return "\(heartRate) bpm"
    }
}

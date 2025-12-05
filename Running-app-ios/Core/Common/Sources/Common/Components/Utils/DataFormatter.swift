//
//  DataFormatter.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import Foundation
import Localization

public final class DataFormatter {
    
    public static func pace(seconds: Double) -> String {
        guard seconds > 0 else { return "--:--" }
        
        let m = Int(seconds) / 60
        let s = Int(seconds) % 60
        return "\(m):\(String(format: "%02d", s)) /km"
    }
    
    public static func distance(_ distance: Double) -> String {
        String(format: "%.2f km", distance)
    }
    
    public static func time(_ time: Double) -> String {
        let totalSeconds = Int(time)
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
    
    public static func heartRate(_ heartRate: Int?) -> String {
        guard let heartRate else { return "- \(Localizables.Common.bpm)" }
        return "\(heartRate) \(Localizables.Common.bpm)"
    }
    
    public static func heartRateRange(minHeartRate: Int?, maxHeartRate: Int?) -> String {
        if let minHeartRate,
           let maxHeartRate {
            if minHeartRate == 0 {
                return "<\(maxHeartRate) \(Localizables.Common.bpm)"
            } else if maxHeartRate == 250 {
                return "\(minHeartRate)+ \(Localizables.Common.bpm)"
            }
            return "\(minHeartRate)-\(maxHeartRate) \(Localizables.Common.bpm)"
        } else if let minHeartRate {
            return "\(minHeartRate)+ \(Localizables.Common.bpm)"
        } else if let maxHeartRate {
            return "<\(maxHeartRate) \(Localizables.Common.bpm)"
        }
        return ""
    }
    
    public static func elevation(_ meters: Double) -> String {
        "\(Int(meters)) m"
    }
    
    public static func cadence(_ steps: Int) -> String {
        "\(steps) \(Localizables.Common.spm)"
    }
    
    public static func verticalOscillation(_ centimeters: Double) -> String {
        String(format: "%.1f cm", centimeters)
    }
    
    public static func groundContactTime(_ millisecs: Int) -> String {
        "\(millisecs) ms"
    }
    
    public static func age(_ age: Int) -> String {
        "(\(age) \(Localizables.Common.years))"
    }
    
    public static func shortDate(_ date: Date?) -> String {
        guard let date else { return "" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd"
        return formatter.string(from: date).localizedCapitalized
    }
}

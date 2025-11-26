//
//  WorkoutFormatter.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

public class WorkoutFormatter {
    
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
        guard let heartRate else { return "- bpm" }
        return "\(heartRate) bpm"
    }
    
    public static func elevation(_ meters: Double) -> String {
        "\(Int(meters)) m"
    }
    
    public static func cadence(_ steps: Int) -> String {
        "\(steps) spm"
    }
    
    public static func verticalOscillation(_ centimeters: Double) -> String {
        String(format: "%.1f cm", centimeters)
    }
    
    public static func groundContactTime(_ millisecs: Int) -> String {
        "\(millisecs) ms"
    }
}

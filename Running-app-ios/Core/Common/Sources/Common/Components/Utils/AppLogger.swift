//
//  AppLogger.swift
//  Common
//
//  Created by Alfonso Boizas Crespo on 20/01/26.
//

import Foundation
import os

public enum AppLogger {
    
    private static let subsystem = Bundle.main.bundleIdentifier ?? "RunningApp"
    
    public static let app = Logger(subsystem: subsystem, category: "app")
    public static let workouts = Logger(subsystem: subsystem, category: "workouts")
    public static let importFlow = Logger(subsystem: subsystem, category: "import")
    public static let search = Logger(subsystem: subsystem, category: "search")
    public static let profile = Logger(subsystem: subsystem, category: "profile")
    public static let workoutDetail = Logger(subsystem: subsystem, category: "workout-detail")
    public static let userConfig = Logger(subsystem: subsystem, category: "user-configuration")
    public static let appleHealth = Logger(subsystem: subsystem, category: "apple-health")
}

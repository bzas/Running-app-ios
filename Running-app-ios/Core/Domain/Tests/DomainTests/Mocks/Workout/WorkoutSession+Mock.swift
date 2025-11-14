//
//  WorkoutSession+Mock.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

public extension WorkoutSession {
    
    public static let mock = WorkoutSession(
        name: "Afternoon run",
        timestamp: Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 14))!,
        heartRate: 170,
        cadence: 178,
        speed: 12.5,
        distance: 10000,
        totalTime: 1000,
        sessionTrackPoints: [.mock]
    )
}

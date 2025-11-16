//
//  WorkoutSession.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation

public struct WorkoutSession: Identifiable, Sendable {
    
    public let id = UUID()
    public var name: String = "Running"
    public var timestamp: Date?
    public var heartRate: Int?
    public var maxHeartRate: Int?
    public var minHeartRate: Int?
    public var cadence: Int?
    public var speed: Double
    public var distance: Double
    public var totalTime: Double
    public var latitude: Double?
    public var longitude: Double?
    public var sessionTrackPoints: [WorkoutSessionTrackPoint]
    public var sessionKmTrackPoints: [WorkoutSessionTrackPoint] = []
    public var paceInSecondsPerKm: [Double] = []
    public var distanceInKm: Double
    public var paceInSeconds: Double = 0
    
    public init(
        timestamp: Date?,
        heartRate: Int?,
        maxHeartRate: Int?,
        minHeartRate: Int?,
        cadence: Int?,
        speed: Double,
        distance: Double,
        totalTime: Double,
        latitude: Double?,
        longitude: Double?,
        sessionTrackPoints: [WorkoutSessionTrackPoint]
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
        self.sessionTrackPoints = sessionTrackPoints
        self.distanceInKm = distance / 1000.0
        self.paceInSeconds = getPaceInSeconds()
        self.sessionKmTrackPoints = getKmTrackPoints()
        self.paceInSecondsPerKm = computeSecondsPerKm()
        self.name = sessionName()
    }
}

// MARK: - Private methods

private extension WorkoutSession {
    
    func sessionName() -> String {
        guard let timestamp else { return "Running" }

        switch Calendar.current.component(.hour, from: timestamp) {
        case 5..<12:
            return "Morning Run"
        case 12..<18:
            return "Afternoon Run"
        case 18..<22:
            return "Evening Run"
        default:
            return "Night Run"
        }
    }
    
    func getPaceInSeconds() -> Double {
        guard speed <= 0 else {
            return 1000.0 / speed
        }
        
        guard distanceInKm > 0 else { return 0 }
        return totalTime / distanceInKm
    }
    
    func getKmTrackPoints() -> [WorkoutSessionTrackPoint] {
        let kilometerPoints = Array(stride(from: 0, through: distance, by: 1000))
        
        return kilometerPoints.compactMap { kmPoint in
            sessionTrackPoints.min { abs($0.distance - kmPoint) < abs($1.distance - kmPoint) }
        }
    }
    
    func computeSecondsPerKm() -> [Double] {
        guard sessionKmTrackPoints.count > 1 else { return [] }

        var secondsPerKm: [Double] = []
        for i in 1..<sessionKmTrackPoints.count {
            let prev = sessionKmTrackPoints[i - 1]
            let curr = sessionKmTrackPoints[i]
            secondsPerKm.append(
                WorkoutSessionTrackPoint.secondsBetween(
                    previous: prev,
                    current: curr
                )
            )
        }

        return secondsPerKm
    }
}

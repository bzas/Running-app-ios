//
//  HKWorkout+Factory.swift
//  HealthKitService
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import HealthKit
import CoreLocation
import Domain

extension HKWorkout {
    
    func toLightWeightDomain() -> WorkoutSession {
        WorkoutSession(
            id: uuid,
            timestamp: startDate,
            distance: totalDistance?.doubleValue(for: .meter()) ?? 0,
            totalTime: duration
        )
    }
    
    func toDomain(
        healthStore: HKHealthStore,
        lightWeightParsing: Bool = true
    ) async throws -> WorkoutSession {
        guard !lightWeightParsing else {
            return toLightWeightDomain()
        }
        
        let locations = try await routeLocations(healthStore: healthStore)
        let heartRateSamples = try await heartRateSamples(healthStore: healthStore)
        let trackPoints = trackPoints(
            from: locations,
            heartRateSamples: heartRateSamples
        )
        
        let distance = totalDistance?.doubleValue(for: .meter()) ?? 0
        let duration = max(self.duration, 0)
        let speed = duration > 0 ? distance / duration : 0
        let heartRateStats = heartRateValues()
        
        return WorkoutSession(
            id: uuid,
            timestamp: startDate,
            heartRate: heartRateStats.average,
            maxHeartRate: heartRateStats.maximum,
            minHeartRate: heartRateStats.minimum,
            cadence: nil,
            speed: speed,
            distance: distance,
            totalTime: duration,
            latitude: nil,
            longitude: nil,
            sessionTrackPoints: trackPoints,
            photos: [],
            verticalOscillation: nil,
            groundContactTime: nil
        )
    }
}

// MARK: - Private methods

private extension HKWorkout {
    
    struct HeartRateValues {
        let average: Int?
        let maximum: Int?
        let minimum: Int?
    }
    
    func heartRateValues() -> HeartRateValues {
        let unit = HKUnit.count().unitDivided(by: .minute())
        let average = intValue(statisticsValue(.heartRate, unit: unit) { $0.averageQuantity() })
        let maximum = intValue(statisticsValue(.heartRate, unit: unit) { $0.maximumQuantity() })
        let minimum = intValue(statisticsValue(.heartRate, unit: unit) { $0.minimumQuantity() })
        return HeartRateValues(
            average: average,
            maximum: maximum,
            minimum: minimum
        )
    }
    
    func statisticsValue(
        _ identifier: HKQuantityTypeIdentifier,
        unit: HKUnit,
        selector: (HKStatistics) -> HKQuantity?
    ) -> Double? {
        guard let type = HKQuantityType.quantityType(forIdentifier: identifier),
              let stats = statistics(for: type),
              let quantity = selector(stats) else {
            return nil
        }
        
        return quantity.doubleValue(for: unit)
    }
    
    func intValue(_ value: Double?) -> Int? {
        guard let value else { return nil }
        return Int(value.rounded())
    }
    
    func routeLocations(healthStore: HKHealthStore) async throws -> [CLLocation] {
        let routeType = HKSeriesType.workoutRoute()
        let predicate = HKQuery.predicateForObjects(from: self)
        let sort = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        
        let routes: [HKWorkoutRoute] = try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: routeType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [sort]
            ) { _, samples, error in
                if let error { return continuation.resume(throwing: error) }
                let routes = (samples as? [HKWorkoutRoute]) ?? []
                continuation.resume(returning: routes)
            }
            healthStore.execute(query)
        }
        
        guard !routes.isEmpty else { return [] }
        
        var allLocations: [CLLocation] = []
        for route in routes {
            let locations = try await locations(for: route, healthStore: healthStore)
            allLocations.append(contentsOf: locations)
        }
        
        return allLocations
    }

    func heartRateSamples(healthStore: HKHealthStore) async throws -> [HKQuantitySample] {
        guard let type = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            return []
        }
        
        let predicate = HKQuery.predicateForObjects(from: self)
        let sort = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        
        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: type,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: [sort]
            ) { _, samples, error in
                if let error { return continuation.resume(throwing: error) }
                let samples = (samples as? [HKQuantitySample]) ?? []
                continuation.resume(returning: samples)
            }
            healthStore.execute(query)
        }
    }
    
    func locations(
        for route: HKWorkoutRoute,
        healthStore: HKHealthStore
    ) async throws -> [CLLocation] {
        try await withCheckedThrowingContinuation { continuation in
            let state = RouteQueryState()
            
            let query = HKWorkoutRouteQuery(route: route) { _, newLocations, done, error in
                Task {
                    if let error {
                        if await state.finishIfNeeded() {
                            continuation.resume(throwing: error)
                        }
                        return
                    }
                    
                    if let newLocations {
                        await state.append(newLocations)
                    }
                    
                    if done {
                        if await state.finishIfNeeded() {
                            let locations = await state.allLocations()
                            continuation.resume(returning: locations)
                        }
                    }
                }
            }
            
            healthStore.execute(query)
        }
    }
    
    func trackPoints(from locations: [CLLocation]) -> [WorkoutSessionTrackPoint] {
        trackPoints(from: locations, heartRateSamples: [])
    }

    func trackPoints(
        from locations: [CLLocation],
        heartRateSamples: [HKQuantitySample]
    ) -> [WorkoutSessionTrackPoint] {
        guard !locations.isEmpty else { return [] }
        
        let unit = HKUnit.count().unitDivided(by: .minute())
        var distance: Double = 0
        var previousLocation: CLLocation?
        var sampleIndex = 0
        let sortedSamples = heartRateSamples
        
        return locations.map { location in
            if let previousLocation {
                distance += location.distance(from: previousLocation)
            }
            previousLocation = location
            
            while sampleIndex + 1 < sortedSamples.count,
                  sortedSamples[sampleIndex + 1].startDate <= location.timestamp {
                sampleIndex += 1
            }
            
            let heartRate: Int?
            if !sortedSamples.isEmpty,
               sortedSamples[sampleIndex].startDate <= location.timestamp {
                heartRate = Int(
                    sortedSamples[sampleIndex]
                        .quantity
                        .doubleValue(for: unit)
                        .rounded()
                )
            } else {
                heartRate = nil
            }
            
            return WorkoutSessionTrackPoint(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                altitude: location.altitude,
                distance: distance,
                heartRate: heartRate,
                timestamp: location.timestamp,
                cadence: nil
            )
        }
    }
}

// MARK: - Helper actor

private actor RouteQueryState {
    private var locations: [CLLocation] = []
    private var didFinish = false
    
    func append(_ newLocations: [CLLocation]) {
        locations.append(contentsOf: newLocations)
    }
    
    func finishIfNeeded() -> Bool {
        if didFinish {
            return false
        }
        didFinish = true
        return true
    }
    
    func allLocations() -> [CLLocation] {
        locations
    }
}

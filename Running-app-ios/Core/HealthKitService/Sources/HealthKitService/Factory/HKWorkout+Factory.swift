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
        let cadenceSamples = try await cadenceSamples(healthStore: healthStore)
        let trackPoints = trackPoints(
            from: locations,
            heartRateSamples: heartRateSamples,
            cadenceSamples: cadenceSamples
        )
        
        let distance = totalDistance?.doubleValue(for: .meter()) ?? 0
        let duration = max(self.duration, 0)
        let speed = duration > 0 ? distance / duration : 0
        let heartRateStats = heartRateValues()
        let verticalOscillation = verticalOscillationValue()
        let groundContactTime = groundContactTimeValue()
        let cadence = cadenceValue(duration: duration)
        
        return WorkoutSession(
            id: uuid,
            timestamp: startDate,
            heartRate: heartRateStats.average,
            maxHeartRate: heartRateStats.maximum,
            minHeartRate: heartRateStats.minimum,
            cadence: cadence,
            speed: speed,
            distance: distance,
            totalTime: duration,
            sessionTrackPoints: trackPoints,
            photos: [],
            verticalOscillation: verticalOscillation,
            groundContactTime: groundContactTime
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

    func verticalOscillationValue() -> Double? {
        let unit = HKUnit.meterUnit(with: .centi)
        return statisticsValue(.runningVerticalOscillation, unit: unit) { $0.averageQuantity() }
    }
    
    func groundContactTimeValue() -> Int? {
        let unit = HKUnit.secondUnit(with: .milli)
        let value = statisticsValue(.runningGroundContactTime, unit: unit) { $0.averageQuantity() }
        return intValue(value)
    }
    
    func cadenceValue(duration: Double) -> Int? {
        guard duration > 0 else { return nil }
        let unit = HKUnit.count()
        let steps = statisticsValue(.stepCount, unit: unit) { $0.sumQuantity() }
        guard let steps else { return nil }
        let cadence = steps / duration * 60
        return intValue(cadence)
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

    func cadenceSamples(healthStore: HKHealthStore) async throws -> [HKQuantitySample] {
        guard let type = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
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
        trackPoints(from: locations, heartRateSamples: [], cadenceSamples: [])
    }

    func trackPoints(
        from locations: [CLLocation],
        heartRateSamples: [HKQuantitySample],
        cadenceSamples: [HKQuantitySample]
    ) -> [WorkoutSessionTrackPoint] {
        guard !locations.isEmpty else { return [] }
        
        let unit = HKUnit.count().unitDivided(by: .minute())
        var distance: Double = 0
        var previousLocation: CLLocation?
        var heartRateIndex = 0
        var cadenceIndex = 0
        let sortedHeartRateSamples = heartRateSamples
        let sortedCadenceSamples = cadenceSamples
        
        return locations.map { location in
            if let previousLocation {
                distance += location.distance(from: previousLocation)
            }
            previousLocation = location
            
            while heartRateIndex + 1 < sortedHeartRateSamples.count,
                  sortedHeartRateSamples[heartRateIndex + 1].startDate <= location.timestamp {
                heartRateIndex += 1
            }
            
            while cadenceIndex + 1 < sortedCadenceSamples.count,
                  sortedCadenceSamples[cadenceIndex + 1].startDate <= location.timestamp {
                cadenceIndex += 1
            }
            
            let heartRate: Int?
            if !sortedHeartRateSamples.isEmpty,
               sortedHeartRateSamples[heartRateIndex].startDate <= location.timestamp {
                heartRate = Int(
                    sortedHeartRateSamples[heartRateIndex]
                        .quantity
                        .doubleValue(for: unit)
                        .rounded()
                )
            } else {
                heartRate = nil
            }

            let cadence: Int?
            if !sortedCadenceSamples.isEmpty {
                let sample = sortedCadenceSamples[cadenceIndex]
                if sample.startDate <= location.timestamp,
                   sample.endDate >= location.timestamp {
                    let seconds = sample.endDate.timeIntervalSince(sample.startDate)
                    if seconds > 0 {
                        let steps = sample.quantity.doubleValue(for: .count())
                        cadence = Int((steps / seconds * 60).rounded())
                    } else {
                        cadence = nil
                    }
                } else {
                    cadence = nil
                }
            } else {
                cadence = nil
            }
            
            return WorkoutSessionTrackPoint(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                altitude: location.altitude,
                distance: distance,
                heartRate: heartRate,
                timestamp: location.timestamp,
                cadence: cadence
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

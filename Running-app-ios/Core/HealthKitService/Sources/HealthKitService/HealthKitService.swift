// The Swift Programming Language
// https://docs.swift.org/swift-book

import HealthKit
import Domain

public actor HealthKitService: HealthKitServiceProtocol {
    
    public init() {}
    
    public func requestUserPermission() async throws {
        let healthStore = HKHealthStore()

        let typesToShare: Set<HKSampleType> = []
        let typesToRead: Set = [
            HKQuantityType.workoutType(),
            HKSeriesType.workoutRoute(),
            HKQuantityType(.heartRate)
        ]

        if HKHealthStore.isHealthDataAvailable() {
            try await healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead)
        } else {
            // Throw error
        }
    }
    
    public func fetchWorkouts(limit: Int) async throws -> [WorkoutSession] {
        let sampleType = HKObjectType.workoutType()
        let predicate = HKQuery.predicateForWorkouts(with: .running)
        let sort = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)

        let workouts: [HKWorkout] = try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: sampleType,
                predicate: predicate,
                limit: limit,
                sortDescriptors: [sort]
            ) { _, samples, error in
                if let error { return continuation.resume(throwing: error) }
                let workouts = (samples as? [HKWorkout]) ?? []
                continuation.resume(returning: workouts)
            }
            HKHealthStore().execute(query)
        }
        
        let watchWorkouts = workouts.filter { workout in
            if let model = workout.device?.model {
                return model.localizedCaseInsensitiveContains("watch")
            }
            
            if let productType = workout.sourceRevision.productType {
                return productType.localizedCaseInsensitiveContains("watch")
            }
            
            return false
        }
        
        return watchWorkouts.map { $0.toLightWeightDomain() }
    }
    
    public func fetchFullWorkout(lightWeightSession: WorkoutSession) async throws -> WorkoutSession {
        let predicate = HKQuery.predicateForObject(with: lightWeightSession.id)
        let healthStore = HKHealthStore()
        let workouts: [HKWorkout] = try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: HKObjectType.workoutType(),
                predicate: predicate,
                limit: 1,
                sortDescriptors: nil
            ) { _, samples, error in
                if let error { return continuation.resume(throwing: error) }
                let workouts = (samples as? [HKWorkout]) ?? []
                continuation.resume(returning: workouts)
            }
            healthStore.execute(query)
        }
        
        guard let workout = workouts.first else {
            return lightWeightSession
        }
        
        return try await workout.toDomain(healthStore: healthStore, lightWeightParsing: false)
    }
}

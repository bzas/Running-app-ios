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
            HKQuantityType.workoutType()
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
        
        return workouts.map { $0.toDomain() }
    }
}

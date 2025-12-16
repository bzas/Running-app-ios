// The Swift Programming Language
// https://docs.swift.org/swift-book

import HealthKit

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
}

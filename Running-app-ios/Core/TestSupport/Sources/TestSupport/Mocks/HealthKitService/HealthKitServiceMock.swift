//
//  HealthKitServiceMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 16/12/25.
//

import HealthKitService
import Domain

public actor HealthKitServiceMock: HealthKitServiceProtocol {

    public var requestUserPermissionCallCount = 0
    public private(set) var fetchWorkoutsCallCount = 0
    public private(set) var fetchWorkoutsLimits: [Int] = []
    public var errorToThrow: Error?
    public private(set) var fetchFullWorkoutCallCount = 0
    public private(set) var fetchFullWorkoutInputs: [WorkoutSession] = []
    
    private var fetchWorkoutsResult: [WorkoutSession] = []
    private var fetchWorkoutsError: Error?
    private var fetchFullWorkoutResult: WorkoutSession?
    private var fetchFullWorkoutError: Error?
    
    public init(
        requestUserPermissionCallCount: Int = 0,
        errorToThrow: Error? = nil
    ) {
        self.requestUserPermissionCallCount = requestUserPermissionCallCount
        self.errorToThrow = errorToThrow
    }

    public func setError(_ error: Error?) {
        errorToThrow = error
    }
    
    public func setFetchWorkoutsResult(_ workouts: [WorkoutSession]) {
        fetchWorkoutsResult = workouts
    }
    
    public func setFetchWorkoutsError(_ error: Error?) {
        fetchWorkoutsError = error
    }
    
    public func setFetchFullWorkoutResult(_ session: WorkoutSession?) {
        fetchFullWorkoutResult = session
    }
    
    public func setFetchFullWorkoutError(_ error: Error?) {
        fetchFullWorkoutError = error
    }

    public func requestUserPermission() async throws {
        requestUserPermissionCallCount += 1

        if let errorToThrow {
            throw errorToThrow
        }
    }
    
    public func fetchWorkouts(limit: Int) async throws -> [WorkoutSession] {
        fetchWorkoutsCallCount += 1
        fetchWorkoutsLimits.append(limit)

        if let fetchWorkoutsError {
            throw fetchWorkoutsError
        }
        
        return fetchWorkoutsResult
    }
    
    public func fetchFullWorkout(lightWeightSession: WorkoutSession) async throws -> WorkoutSession {
        fetchFullWorkoutCallCount += 1
        fetchFullWorkoutInputs.append(lightWeightSession)
        
        if let fetchFullWorkoutError {
            throw fetchFullWorkoutError
        }
        
        return fetchFullWorkoutResult ?? lightWeightSession
    }
}

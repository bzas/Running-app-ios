//
//  GetHealthWorkoutsUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import Application
import Domain

public actor GetHealthWorkoutsUseCaseMock: GetHealthWorkoutsUseCaseProtocol {
    
    // MARK: - Tracking
    
    public private(set) var fetchWorkoutsCallCount = 0
    
    // MARK: - Stubbing
    
    public var workoutsResult: [WorkoutSession] = []
    public var errorToThrow: Error?
    
    public init() {}
    
    public func fetchWorkouts() async throws -> [WorkoutSession] {
        fetchWorkoutsCallCount += 1
        
        if let errorToThrow {
            throw errorToThrow
        }
        
        return workoutsResult
    }
}

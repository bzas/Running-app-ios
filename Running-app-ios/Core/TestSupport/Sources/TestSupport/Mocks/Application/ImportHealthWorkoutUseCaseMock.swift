//
//  ImportHealthWorkoutUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import Application
import Domain

public actor ImportHealthWorkoutUseCaseMock: ImportHealthWorkoutUseCaseProtocol {
    
    // MARK: - Tracking
    
    public private(set) var fetchCompleteWorkoutCallCount = 0
    public private(set) var lastLightWeightSession: WorkoutSession?
    
    // MARK: - Stubbing
    
    public var errorToThrow: Error?
    
    public init() {}
    
    public func fetchCompleteWorkout(lightWeightSession: WorkoutSession) async throws {
        fetchCompleteWorkoutCallCount += 1
        lastLightWeightSession = lightWeightSession
        
        if let errorToThrow {
            throw errorToThrow
        }
    }
}

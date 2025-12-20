//
//  ImportHealthWorkoutUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import Testing
import TestSupport
import Domain
@testable import Application

struct ImportHealthWorkoutUseCaseTests {
    
    @Test func testFetchCompleteWorkoutSavesSession() async throws {
        let healthKitService = HealthKitServiceMock()
        let repository = WorkoutRepositoryMock()
        let useCase = ImportHealthWorkoutUseCase(
            healthKitService: healthKitService,
            repository: repository
        )
        let lightWeightSession = WorkoutSession.mock
        let fullSession = WorkoutSession.mock
        await healthKitService.setFetchFullWorkoutResult(fullSession)
        
        try await useCase.fetchCompleteWorkout(lightWeightSession: lightWeightSession)
        
        let callCount = await healthKitService.fetchFullWorkoutCallCount
        let inputs = await healthKitService.fetchFullWorkoutInputs
        let savedSessions = await repository.savedSessions
        #expect(callCount == 1)
        #expect(inputs.map { $0.id } == [lightWeightSession.id])
        #expect(savedSessions.map { $0.id } == [fullSession.id])
    }
    
    @Test func testFetchCompleteWorkoutFailure() async throws {
        let healthKitService = HealthKitServiceMock()
        let repository = WorkoutRepositoryMock()
        let useCase = ImportHealthWorkoutUseCase(
            healthKitService: healthKitService,
            repository: repository
        )
        let lightWeightSession = WorkoutSession.mock
        await healthKitService.setFetchFullWorkoutError(MockError.sample)
        
        await #expect(throws: Error.self) {
            try await useCase.fetchCompleteWorkout(lightWeightSession: lightWeightSession)
        }
        
        let callCount = await healthKitService.fetchFullWorkoutCallCount
        let savedSessions = await repository.savedSessions
        #expect(callCount == 1)
        #expect(savedSessions.isEmpty)
    }
}

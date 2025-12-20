//
//  GetHealthWorkoutsUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import Testing
import TestSupport
import Domain
@testable import Application

struct GetHealthWorkoutsUseCaseTests {
    
    @Test func testFetchWorkoutsReturnsSessions() async throws {
        let healthKitService = HealthKitServiceMock()
        let expectedSessions = [WorkoutSession.mock, WorkoutSession.mock]
        await healthKitService.setFetchWorkoutsResult(expectedSessions)
        let useCase = GetHealthWorkoutsUseCase(healthKitService: healthKitService)
        
        let sessions = try await useCase.fetchWorkouts()
        
        #expect(sessions.count == expectedSessions.count)
        let callCount = await healthKitService.fetchWorkoutsCallCount
        let limits = await healthKitService.fetchWorkoutsLimits
        #expect(callCount == 1)
        #expect(limits == [50])
    }
    
    @Test func testFetchWorkoutsFailure() async throws {
        let healthKitService = HealthKitServiceMock()
        let useCase = GetHealthWorkoutsUseCase(healthKitService: healthKitService)
        await healthKitService.setFetchWorkoutsError(MockError.sample)
        
        await #expect(throws: Error.self) {
            _ = try await useCase.fetchWorkouts()
        }
        
        let callCount = await healthKitService.fetchWorkoutsCallCount
        #expect(callCount == 1)
    }
}

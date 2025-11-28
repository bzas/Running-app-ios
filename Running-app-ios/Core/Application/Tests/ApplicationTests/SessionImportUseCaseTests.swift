//
//  SessionImportUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Domain
import TestSupport
@testable import Application

struct SessionImportUseCaseTests {

    @Test func testFetchAllSessions() async throws {
        let repository = WorkoutRepositoryMock()
        let expectedSessions = [WorkoutSession.mock, WorkoutSession.mock]
        await repository.setFetchAllResult(expectedSessions)
        let useCase = SessionImportUseCase(repository: repository)

        let sessions = try await useCase.fetchAllSessions()

        #expect(sessions.count == expectedSessions.count)
        #expect(sessions.first?.id == expectedSessions.first?.id)
    }
}

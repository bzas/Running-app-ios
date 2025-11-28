//
//  WorkoutDeletionUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Domain
import TestSupport
@testable import Application

struct WorkoutDeletionUseCaseTests {

    @Test func testDeleteSession() async throws {
        let repository = WorkoutRepositoryMock()
        let useCase = WorkoutDeletionUseCase(repository: repository)
        let session = WorkoutSession.mock

        try await useCase.delete(session)

        let deleted = await repository.deletedSessions
        #expect(deleted.count == 1)
        #expect(deleted.first?.id == session.id)
    }
}

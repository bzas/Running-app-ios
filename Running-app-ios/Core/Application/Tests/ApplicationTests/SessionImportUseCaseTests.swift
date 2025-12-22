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
import Foundation

struct SessionImportUseCaseTests {

    @Test func testFetchAllSessions() async throws {
        let repository = WorkoutRepositoryMock()
        let expectedSessions = [WorkoutSession.mock, WorkoutSession.mock]
        await repository.setFetchAllResult(expectedSessions)
        let useCase = SessionImportUseCase(repository: repository)

        let sessions = try await useCase.fetchAllSessions(lightWeight: false)

        #expect(sessions.count == expectedSessions.count)
        #expect(sessions.first?.id == expectedSessions.first?.id)
        #expect(sessions.first?.sessionTrackPoints.isEmpty == false)
    }

    @Test func testFetchAllSessionsLightweight() async throws {
        let repository = WorkoutRepositoryMock()
        let expectedSessions = [WorkoutSession.lightWeightMock, WorkoutSession.lightWeightMock]
        await repository.setFetchAllResult(expectedSessions)
        let useCase = SessionImportUseCase(repository: repository)

        let sessions = try await useCase.fetchAllSessions(lightWeight: true)

        #expect(sessions.count == expectedSessions.count)
        #expect(sessions.first?.id == expectedSessions.first?.id)
        #expect(sessions.first?.sessionTrackPoints.isEmpty == true)
    }
    
    @Test func testFetchSession() async throws {
        let repository = WorkoutRepositoryMock()
        let expectedSession = WorkoutSession.mock
        await repository.setFetchSessionResult(expectedSession)
        let useCase = SessionImportUseCase(repository: repository)
        
        let session = try await useCase.fetchSession(with: expectedSession.id)
        
        #expect(session.id == expectedSession.id)
    }
    
    @Test func testFetchSessionFailure() async throws {
        let repository = WorkoutRepositoryMock()
        await repository.setFetchSessionError(DatabaseMockError.sessionNotFound)
        let useCase = SessionImportUseCase(repository: repository)
        
        await #expect(throws: Error.self) {
            _ = try await useCase.fetchSession(with: UUID())
        }
    }
}

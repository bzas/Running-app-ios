import Testing
import Foundation
import Domain
import Application
import TestSupport
@testable import Workouts

@MainActor
struct WorkoutsViewModelTests {
    
    @Test func testInitFetchesSessions() async throws {
        let repository = WorkoutRepositoryMock()
        await repository.setFetchAllResult([.mock])
        let sessionImportUseCase = SessionImportUseCaseMock(repository: repository)
        await sessionImportUseCase.setFetchAllResult([.mock])
        let sut = makeSUT(sessionImportUseCase: sessionImportUseCase)
        
        await waitForTasks()
        
        #expect(sut.sessions.count == 1)
        #expect(sut.isLoading == false)
    }
    
    @Test func testImportFileCallsGarminUseCaseAndRefreshes() async throws {
        let repository = WorkoutRepositoryMock()
        await repository.setFetchAllResult([.mock])
        let sessionImportUseCase = SessionImportUseCaseMock(repository: repository)
        await sessionImportUseCase.setFetchAllResult([.mock])
        let garminUseCase = GarminImportUseCaseMock(
            garminService: GarminServiceMock(),
            repository: repository
        )
        let sut = makeSUT(
            garminUseCase: garminUseCase,
            sessionImportUseCase: sessionImportUseCase
        )
        
        sut.importFile(from: URL(fileURLWithPath: "/tmp/file.fit"))
        await waitForTasks()
        
        let importCount = await garminUseCase.importCallCount
        #expect(importCount == 1)
        #expect(sut.isLoading == false)
        #expect(sut.sessions.isEmpty == false)
    }
    
    @Test func testDeleteSessionsRemovesAndCallsUseCase() async throws {
        let repository = WorkoutRepositoryMock()
        let session = WorkoutSession.mock
        await repository.setFetchAllResult([session])
        let sessionImportUseCase = SessionImportUseCaseMock(repository: repository)
        await sessionImportUseCase.setFetchAllResult([session])
        let workoutDeletionUseCase = WorkoutDeletionUseCaseMock(repository: repository)
        let sut = makeSUT(
            sessionImportUseCase: sessionImportUseCase,
            workoutDeletionUseCase: workoutDeletionUseCase
        )
        sut.fetchAll()
        await waitUntilSessionsLoaded(sut, expectedCount: 1)
        
        sut.deleteSessions(at: IndexSet(integer: 0))
        await waitForTasks()
        
        let deleted = await workoutDeletionUseCase.deletedSessions
        #expect(sut.sessions.isEmpty)
        #expect(deleted.count == 1)
        #expect(deleted.first?.id == session.id)
    }
    
    @Test func testFetchAllErrorShowsAlert() async throws {
        let repository = WorkoutRepositoryMock()
        let sessionImportUseCase = SessionImportUseCaseMock(repository: repository)
        await sessionImportUseCase.setErrorToThrow(TestError.stub)
        let sut = makeSUT(sessionImportUseCase: sessionImportUseCase)
        
        await waitUntil { sut.shouldShowErrorAlert }
        
        #expect(sut.shouldShowErrorAlert)
        #expect(sut.errorTitle != nil)
    }
}

// MARK: - Helpers

private extension WorkoutsViewModelTests {
    
    func makeSUT(
        garminUseCase: GarminImportUseCaseProtocol = GarminImportUseCaseMock(
            garminService: GarminServiceMock(),
            repository: WorkoutRepositoryMock()
        ),
        sessionImportUseCase: SessionImportUseCaseProtocol = SessionImportUseCaseMock(repository: WorkoutRepositoryMock()),
        workoutDeletionUseCase: WorkoutDeletionUseCaseProtocol = WorkoutDeletionUseCaseMock(repository: WorkoutRepositoryMock())
    ) -> WorkoutsViewModel {
        WorkoutsViewModel(
            garminUseCase: garminUseCase,
            sessionImportUseCase: sessionImportUseCase,
            workoutDeletionUseCase: workoutDeletionUseCase
        )
    }
}

private enum TestError: Error {
    case stub
}

private func waitForTasks(nanoseconds: UInt64 = 50_000_000) async {
    try? await Task.sleep(nanoseconds: nanoseconds)
    await Task.yield()
}

@MainActor
private func waitUntilSessionsLoaded(_ sut: WorkoutsViewModel, expectedCount: Int, retries: Int = 10) async {
    for _ in 0..<retries {
        if sut.sessions.count == expectedCount { return }
        await waitForTasks(nanoseconds: 10_000_000)
    }
}

@MainActor
private func waitUntil(_ condition: () -> Bool, retries: Int = 20) async {
    for _ in 0..<retries {
        if condition() { return }
        await waitForTasks(nanoseconds: 20_000_000)
    }
}

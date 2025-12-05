import Testing
import Domain
import Application
import TestSupport
@testable import Search

@MainActor
struct SearchViewModelTests {
    
    @Test func testFetchAllSetsSessionsAndStopsLoading() async throws {
        let repository = WorkoutRepositoryMock()
        let session = WorkoutSession.mock
        await repository.setFetchAllResult([session])
        let useCase = SessionImportUseCaseMock(repository: repository)
        await useCase.setFetchAllResult([session])
        let sut = SearchViewModel(sessionImportUseCase: useCase)
        
        sut.fetchAll()
        await waitForTasks()
        
        #expect(sut.isLoading == false)
        #expect(sut.sessions.count == 1)
    }
    
    @Test func testApplyFiltersMatchesByName() async throws {
        let repository = WorkoutRepositoryMock()
        let sessionA = WorkoutSession.mock
        var sessionB = WorkoutSession.mock
        sessionB.name = "Evening Run"
        await repository.setFetchAllResult([sessionA, sessionB])
        let useCase = SessionImportUseCaseMock(repository: repository)
        await useCase.setFetchAllResult([sessionA, sessionB])
        let sut = SearchViewModel(sessionImportUseCase: useCase)
        sut.fetchAll()
        await waitForTasks()
        
        sut.searchText = "Evening"
        sut.applyFilters()
        
        #expect(sut.sessions.count == 1)
        #expect(sut.sessions.first?.name == "Evening Run")
    }
    
    @Test func testFetchAllOnErrorShowsAlert() async throws {
        let repository = WorkoutRepositoryMock()
        let useCase = SessionImportUseCaseMock(repository: repository)
        await useCase.setErrorToThrow(TestError.stub)
        let sut = SearchViewModel(sessionImportUseCase: useCase)
        
        sut.fetchAll()
        await waitForTasks()
        
        #expect(sut.shouldShowErrorAlert)
        #expect(sut.errorTitle != nil)
    }
}

// MARK: - Helpers

private enum TestError: Error {
    case stub
}

private func waitForTasks(nanoseconds: UInt64 = 20_000_000) async {
    try? await Task.sleep(nanoseconds: nanoseconds)
    await Task.yield()
}

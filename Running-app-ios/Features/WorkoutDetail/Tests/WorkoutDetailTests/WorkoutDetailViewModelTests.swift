import Testing
import Domain
import Application
import TestSupport
@testable import WorkoutDetail

@MainActor
struct WorkoutDetailViewModelTests {
    
    @Test func testSetupReloadsSessionAndCharts() async throws {
        let workoutRepository = WorkoutRepositoryMock()
        var session = WorkoutSession.mock
        session.paceInSecondsPerKm = [300, 310, 290]
        session.sessionTrackPoints = Array(repeating: WorkoutSessionTrackPoint.mock, count: 40)
        let sessionImportUseCase = SessionImportUseCaseMock(repository: workoutRepository)
        await sessionImportUseCase.setFetchSessionResult(session)
        let getUserUseCase = GetUserUseCaseMock(repository: UserRepositoryMock())
        await getUserUseCase.setCurrentUserResult(.mock)
        
        let sut = makeSUT(
            session: session,
            getUserUseCase: getUserUseCase,
            sessionImportUseCase: sessionImportUseCase
        )
        
        sut.setup()
        await waitForTasks()
        
        #expect(sut.paceChartData.count == session.paceInSecondsPerKm.count)
        #expect(sut.paceChartStrideValue > 0)
        #expect(sut.elevationChartData.isEmpty == false)
        #expect(sut.hrChartData.isEmpty == false)
        #expect(sut.cadenceChartData.isEmpty == false)
    }
    
    @Test func testDeletePhotoRemovesAndPersists() async throws {
        let workoutRepository = WorkoutRepositoryMock()
        let updateGalleryUseCase = UpdateGalleryUseCaseMock(repository: workoutRepository)
        var session = WorkoutSession.mock
        let photo = SessionPhoto.mock
        session.photos = [photo]
        
        let sut = makeSUT(
            session: session,
            updateGalleryUseCase: updateGalleryUseCase
        )
        sut.presentedPhoto = photo
        
        sut.deletePhoto(photo)
        await waitForTasks()
        
        let updatedSessions = await updateGalleryUseCase.updatedSessions
        #expect(updatedSessions.count == 1)
        #expect(updatedSessions.first?.photos.contains(where: { $0.id == photo.id }) == false)
        #expect(sut.presentedPhoto == nil)
    }
}

// MARK: - Helpers

private extension WorkoutDetailViewModelTests {
    
    func makeSUT(
        session: WorkoutSession = .mock,
        getUserUseCase: GetUserUseCaseProtocol = GetUserUseCaseMock(repository: UserRepositoryMock()),
        updateGalleryUseCase: UpdateGalleryUseCaseProtocol = UpdateGalleryUseCaseMock(repository: WorkoutRepositoryMock()),
        sessionImportUseCase: SessionImportUseCaseProtocol = SessionImportUseCaseMock(repository: WorkoutRepositoryMock()),
        onDismiss: @escaping () -> Void = {}
    ) -> WorkoutDetailViewModel {
        WorkoutDetailViewModel(
            session: session,
            getUserUseCase: getUserUseCase,
            updateGalleryUseCase: updateGalleryUseCase,
            sessionImportUseCase: sessionImportUseCase,
            onDismiss: onDismiss
        )
    }
}

private func waitForTasks(nanoseconds: UInt64 = 20_000_000) async {
    try? await Task.sleep(nanoseconds: nanoseconds)
    await Task.yield()
}

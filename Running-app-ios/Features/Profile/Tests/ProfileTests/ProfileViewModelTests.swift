import Testing
import Foundation
import Domain
import Application
import TestSupport
@testable import Profile

@MainActor
struct ProfileViewModelTests {
    
    @Test func testSetupFetchesUserSessionsAndPhotos() async throws {
        let workoutRepository = WorkoutRepositoryMock()
        let userRepository = UserRepositoryMock()
        var todaySession = WorkoutSession.mock
        todaySession.timestamp = Date()
        
        let getGalleryUseCase = GetGalleryUseCaseMock(repository: workoutRepository)
        await getGalleryUseCase.setPhotosResult([.mock])
        let updateGalleryUseCase = UpdateGalleryUseCaseMock(repository: workoutRepository)
        let getUserUseCase = GetUserUseCaseMock(repository: userRepository)
        await getUserUseCase.setCurrentUserResult(.mock)
        let sessionImportUseCase = SessionImportUseCaseMock(repository: workoutRepository)
        await sessionImportUseCase.setFetchAllResult([todaySession])
        
        let sut = makeSUT(
            getGalleryUseCase: getGalleryUseCase,
            updateGalleryUseCase: updateGalleryUseCase,
            getUserUseCase: getUserUseCase,
            sessionImportUseCase: sessionImportUseCase
        )
        
        sut.setup()
        await waitForTasks()
        
        #expect(sut.sessions.count == 1)
        #expect(sut.sessionDaysAndKmsOfYear.count == 1)
        #expect(sut.photos.count == 1)
        #expect(sut.userInfo?.name == User.mock.name)
        #expect(sut.isShowingEditUser == false)
    }
    
    @Test func testDeletePhotoUpdatesStateAndRepository() async throws {
        let workoutRepository = WorkoutRepositoryMock()
        let updateGalleryUseCase = UpdateGalleryUseCaseMock(repository: workoutRepository)
        let sut = makeSUT(
            getGalleryUseCase: GetGalleryUseCaseMock(repository: workoutRepository),
            updateGalleryUseCase: updateGalleryUseCase,
            getUserUseCase: GetUserUseCaseMock(repository: UserRepositoryMock()),
            sessionImportUseCase: SessionImportUseCaseMock(repository: workoutRepository)
        )
        let photo = SessionPhoto.mock
        sut.photos = [photo]
        sut.presentedPhoto = photo
        
        sut.deletePhoto(photo)
        await waitForTasks()
        
        let deleted = await updateGalleryUseCase.deletedPhotos
        #expect(sut.photos.isEmpty)
        #expect(sut.presentedPhoto == nil)
        #expect(deleted.count == 1)
    }
    
    @Test func testSetup_whenUserFetchFails_setsError() async throws {
        let workoutRepository = WorkoutRepositoryMock()
        let userRepository = UserRepositoryMock()
        let getGalleryUseCase = GetGalleryUseCaseMock(repository: workoutRepository)
        let updateGalleryUseCase = UpdateGalleryUseCaseMock(repository: workoutRepository)
        let getUserUseCase = GetUserUseCaseMock(repository: userRepository)
        await getUserUseCase.setErrorToThrow(TestError.stub)
        let sessionImportUseCase = SessionImportUseCaseMock(repository: workoutRepository)
        
        let sut = makeSUT(
            getGalleryUseCase: getGalleryUseCase,
            updateGalleryUseCase: updateGalleryUseCase,
            getUserUseCase: getUserUseCase,
            sessionImportUseCase: sessionImportUseCase
        )
        
        sut.setup()
        await waitForTasks()
        
        #expect(sut.shouldShowErrorAlert)
        #expect(sut.errorTitle != nil)
    }
}

// MARK: - Helpers

private extension ProfileViewModelTests {
    
    func makeSUT(
        getGalleryUseCase: GetGalleryUseCaseProtocol,
        updateGalleryUseCase: UpdateGalleryUseCaseProtocol,
        getUserUseCase: GetUserUseCaseProtocol,
        sessionImportUseCase: SessionImportUseCaseProtocol
    ) -> ProfileViewModel {
        ProfileViewModel(
            getGalleryUseCase: getGalleryUseCase,
            updateGalleryUseCase: updateGalleryUseCase,
            getUserUseCase: getUserUseCase,
            sessionImportUseCase: sessionImportUseCase
        )
    }
}

private enum TestError: Error {
    case stub
}

private func waitForTasks(nanoseconds: UInt64 = 20_000_000) async {
    try? await Task.sleep(nanoseconds: nanoseconds)
    await Task.yield()
}

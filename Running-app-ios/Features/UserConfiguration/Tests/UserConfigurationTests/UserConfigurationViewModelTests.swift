import Testing
import Domain
import Application
import TestSupport
@testable import UserConfiguration

@MainActor
struct UserConfigurationViewModelTests {
    
    @Test func testInitWithSavedUserPrefillsFields() async throws {
        let savedUser = User.mock
        let sut = makeSUT(savedUser: savedUser)
        
        #expect(sut.name == savedUser.name)
        #expect(sut.age == "\(savedUser.age)")
        #expect(sut.maxHeartRate == "\(savedUser.maxHeartRate)")
    }
    
    @Test func testTrySaveUser_createsUserWhenNoSavedUser() async throws {
        let createMock = CreateUserUseCaseMock(repository: UserRepositoryMock())
        let sut = makeSUT(
            createUserUseCase: createMock,
            savedUser: nil
        )
        sut.name = "Jane"
        sut.age = "30"
        sut.maxHeartRate = "185"
        
        let result = await sut.trySaveUserData()
        
        #expect(result == true)
        let callCount = await createMock.saveCallCount
        #expect(callCount == 1)
    }
    
    @Test func testTrySaveUser_updatesWhenSavedUserExists() async throws {
        var savedUser = User.mock
        savedUser.name = "Existing"
        let editMock = EditUserUseCaseMock(repository: UserRepositoryMock())
        let sut = makeSUT(
            editUserUseCase: editMock,
            savedUser: savedUser
        )
        sut.name = "Updated"
        sut.age = "31"
        sut.maxHeartRate = "180"
        
        let result = await sut.trySaveUserData()
        
        #expect(result == true)
        let updateCount = await editMock.updateCallCount
        let lastUser = await editMock.lastUpdatedUser
        #expect(updateCount == 1)
        #expect(lastUser?.name == "Updated")
    }
    
    @Test func testTrySaveUser_returnsFalseOnInvalidInput() async throws {
        let sut = makeSUT(
            createUserUseCase: CreateUserUseCaseMock(repository: UserRepositoryMock()),
            savedUser: nil
        )
        sut.name = ""
        sut.age = "abc" // invalid
        sut.maxHeartRate = "200"
        
        let result = await sut.trySaveUserData()
        
        #expect(result == false)
    }
}

// MARK: - Helpers

private extension UserConfigurationViewModelTests {
    
    func makeSUT(
        createUserUseCase: CreateUserUseCaseProtocol = CreateUserUseCaseMock(repository: UserRepositoryMock()),
        editUserUseCase: EditUserUseCaseProtocol = EditUserUseCaseMock(repository: UserRepositoryMock()),
        savedUser: User? = nil,
        completion: (() -> Void)? = nil
    ) -> UserConfigurationViewModel {
        UserConfigurationViewModel(
            createUserUseCase: createUserUseCase,
            editUserUseCase: editUserUseCase,
            savedUser: savedUser,
            completion: completion
        )
    }
}

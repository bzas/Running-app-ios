//
//  CreateUserUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Domain
import TestSupport
@testable import Application

struct CreateUserUseCaseTests {

    @Test func testSaveUser() async throws {
        let repository = UserRepositoryMock()
        let useCase = CreateUserUseCase(repository: repository)
        let user = User.mock

        try await useCase.save(user)

        let saved = await repository.savedUsers
        #expect(saved.count == 1)
        #expect(saved.first?.name == user.name)
        #expect(saved.first?.age == user.age)
        #expect(saved.first?.maxHeartRate == user.maxHeartRate)
    }
}

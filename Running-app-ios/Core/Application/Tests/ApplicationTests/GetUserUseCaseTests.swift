//
//  GetUserUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Domain
import TestSupport
@testable import Application

struct GetUserUseCaseTests {

    @Test func testCurrentUser() async throws {
        let repository = UserRepositoryMock()
        let expected = User.mock
        await repository.setFetchCurrentResult(expected)
        let useCase = GetUserUseCase(repository: repository)

        let user = try await useCase.currentUser()

        #expect(user.name == expected.name)
        #expect(user.age == expected.age)
        #expect(user.maxHeartRate == expected.maxHeartRate)
    }
}

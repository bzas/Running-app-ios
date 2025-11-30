//
//  EditUserUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import Testing
import Domain
import TestSupport
@testable import Application

struct EditUserUseCaseTests {
    
    @Test func testUpdateUser() async throws {
        let repository = UserRepositoryMock()
        let useCase = EditUserUseCase(repository: repository)
        
        var user = User.mock
        user.name = "Jane Doe"
        user.age = 40
        user.maxHeartRate = 185
        
        try await useCase.update(user)
        
        let savedUsers = await repository.savedUsers
        #expect(savedUsers.count == 1)
        #expect(savedUsers.first?.name == user.name)
        #expect(savedUsers.first?.age == user.age)
        #expect(savedUsers.first?.maxHeartRate == user.maxHeartRate)
        
        let current = try await repository.fetchCurrent()
        #expect(current.name == user.name)
        #expect(current.age == user.age)
        #expect(current.maxHeartRate == user.maxHeartRate)
    }
}

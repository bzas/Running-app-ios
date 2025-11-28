//
//  UserRepositoryTests.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import SwiftData
import TestSupport
import Domain
@testable import Database

struct UserRepositoryTests {
    
    @Test func testSave() async throws {
        let (repository, container) = try makeRepository()
        let user = User.mock
        
        try await repository.save(user)
        
        let descriptor = FetchDescriptor<UserDataModel>()
        let storedCount = try await MainActor.run {
            try container.mainContext.fetch(descriptor).count
        }
        
        #expect(storedCount == 1)
    }
    
    @Test func testFetchCurrent() async throws {
        let (repository, _) = try makeRepository()
        let user = User.mock
        try await repository.save(user)
        
        let fetched = try await repository.fetchCurrent()
        
        #expect(fetched.name == user.name)
        #expect(fetched.age == user.age)
        #expect(fetched.maxHeartRate == user.maxHeartRate)
    }
}

// MARK: - Helpers

private extension UserRepositoryTests {
    
    func makeRepository() throws -> (UserRepository, ModelContainer) {
        let schema = Schema([UserDataModel.self])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [config])
        let repository = UserRepository(modelContainer: container)
        return (repository, container)
    }
}

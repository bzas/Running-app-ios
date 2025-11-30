//
//  UserRepository.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain
import SwiftData

@ModelActor
public actor UserRepository: UserRepositoryProtocol {
    
    public func save(_ user: User) async throws {
        let model = UserDataModel(from: user)
        modelContext.insert(model)
        try modelContext.save()
    }
    
    public func update(_ user: User) async throws {
        let descriptor = FetchDescriptor<UserDataModel>()
        guard let storedUser = try modelContext.fetch(descriptor).first else {
            throw DatabaseError.noUserData
        }
        
        storedUser.name = user.name
        storedUser.age = user.age
        storedUser.maxHeartRate = user.maxHeartRate
        try modelContext.save()
    }
    
    public func fetchCurrent() async throws -> User {
        let descriptor = FetchDescriptor<UserDataModel>()
        let models = try modelContext.fetch(descriptor)
        
        guard let currentUser = models.first?.toDomain() else {
            throw DatabaseError.noUserData
        }
        
        return currentUser
    }
}

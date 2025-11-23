//
//  WorkoutsUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import Domain

public actor WorkoutsUseCase {
    
    private let repository: WorkoutRepositoryProtocol
    
    public init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchAllSessions() async throws -> [WorkoutSession] {
        try await repository.fetchAll()
    }
    
    public func updatePhotos(_ model: WorkoutSession) async throws {
        try await repository.updatePhotos(model)
    }
}

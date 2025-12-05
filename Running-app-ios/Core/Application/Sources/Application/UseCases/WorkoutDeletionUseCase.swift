//
//  WorkoutDeletionUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 27/11/25.
//

import Domain

public protocol WorkoutDeletionUseCaseProtocol: Sendable {
    func delete(_ session: WorkoutSession) async throws
}

actor WorkoutDeletionUseCase: WorkoutDeletionUseCaseProtocol {
    
    private let repository: WorkoutRepositoryProtocol
    
    init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    func delete(_ session: WorkoutSession) async throws {
        try await repository.delete(session)
    }
}

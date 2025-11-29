//
//  WorkoutDeletionUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 27/11/25.
//

import Domain

public actor WorkoutDeletionUseCase {
    
    private let repository: WorkoutRepositoryProtocol
    
    public init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    public func delete(_ session: WorkoutSession) async throws {
        try await repository.delete(session)
    }
}

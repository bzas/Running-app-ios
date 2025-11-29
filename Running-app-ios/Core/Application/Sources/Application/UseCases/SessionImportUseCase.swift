//
//  SessionImportUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import Domain
import Foundation

public actor SessionImportUseCase {
    
    private let repository: WorkoutRepositoryProtocol
    
    public init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchAllSessions() async throws -> [WorkoutSession] {
        try await repository.fetchAll()
    }
    
    public func fetchSession(with sessionId: UUID) async throws -> WorkoutSession {
        try await repository.fetchSession(with: sessionId)
    }
}

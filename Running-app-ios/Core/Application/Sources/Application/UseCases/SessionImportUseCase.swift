//
//  SessionImportUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import Domain
import Foundation

public protocol SessionImportUseCaseProtocol: Sendable {
    func fetchAllSessions() async throws -> [WorkoutSession]
    func fetchSession(with sessionId: UUID) async throws -> WorkoutSession
}

actor SessionImportUseCase: SessionImportUseCaseProtocol {
    
    private let repository: WorkoutRepositoryProtocol
    
    init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchAllSessions() async throws -> [WorkoutSession] {
        try await repository.fetchAll()
    }
    
    func fetchSession(with sessionId: UUID) async throws -> WorkoutSession {
        try await repository.fetchSession(with: sessionId)
    }
}

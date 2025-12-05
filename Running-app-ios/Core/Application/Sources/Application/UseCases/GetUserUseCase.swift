//
//  GetUserUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 24/11/25.
//

import Domain

public protocol GetUserUseCaseProtocol: Sendable {
    func currentUser() async throws -> User
}

actor GetUserUseCase: GetUserUseCaseProtocol {
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func currentUser() async throws -> User {
        try await repository.fetchCurrent()
    }
}

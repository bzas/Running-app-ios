//
//  UserUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain

public protocol CreateUserUseCaseProtocol: Sendable {
    func save(_ user: User) async throws
}

actor CreateUserUseCase: CreateUserUseCaseProtocol {
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func save(_ user: User) async throws {
        try await repository.save(user)
    }
}

//
//  EditUserUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import Domain

public protocol EditUserUseCaseProtocol: Sendable {
    func update(_ user: User) async throws
}

actor EditUserUseCase: EditUserUseCaseProtocol {
    
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func update(_ user: User) async throws {
        try await repository.update(user)
    }
}

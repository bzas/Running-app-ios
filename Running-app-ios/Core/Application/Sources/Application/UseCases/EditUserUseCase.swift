//
//  EditUserUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import Domain

public actor EditUserUseCase {
    
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func update(_ user: User) async throws {
        try await repository.update(user)
    }
}

//
//  UserUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain

public actor CreateUserUseCase {
    
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func save(_ user: User) async throws {
        try await repository.save(user)
    }
}

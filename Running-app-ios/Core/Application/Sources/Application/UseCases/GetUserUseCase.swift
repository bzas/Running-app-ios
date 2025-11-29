//
//  GetUserUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 24/11/25.
//

import Domain

public actor GetUserUseCase {
    
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func currentUser() async throws -> User {
        try await repository.fetchCurrent()
    }
}

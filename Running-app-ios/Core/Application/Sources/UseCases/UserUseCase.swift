//
//  UserUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain

public actor UserUseCase {
    
    private let repository: UserRepositoryProtocol
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCurrent() async -> User? {
        nil
    }
}

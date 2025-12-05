//
//  CreateUserUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Domain
import Application

public actor CreateUserUseCaseMock: CreateUserUseCaseProtocol {
    
    // MARK: - Tracking
    
    public private(set) var saveCallCount = 0
    public private(set) var lastSavedUser: User?
    public private(set) var savedUsers: [User] = []
    public let repository: UserRepositoryProtocol
    
    // MARK: - Stubbing
    
    public var errorToThrow: Error?
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func save(_ user: User) async throws {
        saveCallCount += 1
        lastSavedUser = user
        savedUsers.append(user)
        
        if let errorToThrow {
            throw errorToThrow
        }
    }
}

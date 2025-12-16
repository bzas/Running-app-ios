//
//  GetUserUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Domain
import Application

public actor GetUserUseCaseMock: GetUserUseCaseProtocol {
    
    // MARK: - Tracking
    
    public private(set) var currentUserCallCount = 0
    public let repository: UserRepositoryProtocol
    
    // MARK: - Stubbing
    
    public var currentUserResult: User?
    public var errorToThrow: Error?
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    public func setCurrentUserResult(_ user: User?) {
        currentUserResult = user
    }

    public func setErrorToThrow(_ error: Error?) {
        errorToThrow = error
    }
    
    public func currentUser() async throws -> User {
        currentUserCallCount += 1
        
        if let errorToThrow {
            throw errorToThrow
        }
        
        guard let currentUserResult else {
            throw DatabaseMockError.noUserData
        }
        
        return currentUserResult
    }
}

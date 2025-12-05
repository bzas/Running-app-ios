//
//  EditUserUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Domain
import Application

public actor EditUserUseCaseMock: EditUserUseCaseProtocol {
    
    // MARK: - Tracking
    
    public private(set) var updateCallCount = 0
    public private(set) var lastUpdatedUser: User?
    public private(set) var updatedUsers: [User] = []
    public let repository: UserRepositoryProtocol
    
    // MARK: - Stubbing
    
    public var errorToThrow: Error?
    
    public init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }
    
    public func update(_ user: User) async throws {
        updateCallCount += 1
        lastUpdatedUser = user
        updatedUsers.append(user)
        
        if let errorToThrow {
            throw errorToThrow
        }
    }
}

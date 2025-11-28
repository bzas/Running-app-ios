//
//  UserRepository+Mock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Domain

public actor UserRepositoryMock: UserRepositoryProtocol {
    
    public private(set) var savedUsers: [User] = []
    public var fetchCurrentResult: User?
    public var fetchCurrentError: Error?

    public init() {}

    public func save(_ user: User) async throws {
        savedUsers.append(user)
    }
    
    public func fetchCurrent() async throws -> User {
        if let error = fetchCurrentError { throw error }
        guard let result = fetchCurrentResult else {
            throw DatabaseMockError.noUserData
        }
        return result
    }

    public func setFetchCurrentResult(_ user: User?) {
        fetchCurrentResult = user
    }

    public func setFetchCurrentError(_ error: Error?) {
        fetchCurrentError = error
    }
}

public enum DatabaseMockError: Error {
    case noUserData
}

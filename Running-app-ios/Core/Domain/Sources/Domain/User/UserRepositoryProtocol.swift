//
//  UserRepositoryProtocol.swift
//  Domain
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

public protocol UserRepositoryProtocol: Sendable {
    
    func save(_ user: User) async throws
    func update(_ user: User) async throws
    func fetchCurrent() async throws -> User
}

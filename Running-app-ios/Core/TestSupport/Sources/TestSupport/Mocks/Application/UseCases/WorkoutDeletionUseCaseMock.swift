//
//  WorkoutDeletionUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Domain
import Application

public actor WorkoutDeletionUseCaseMock: WorkoutDeletionUseCaseProtocol {
    
    // MARK: - Tracking
    
    public private(set) var deleteCallCount = 0
    public private(set) var deletedSessions: [WorkoutSession] = []
    public private(set) var lastDeletedSession: WorkoutSession?
    public let repository: WorkoutRepositoryProtocol
    
    // MARK: - Stubbing
    
    public var errorToThrow: Error?
    
    public init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    public func delete(_ session: WorkoutSession) async throws {
        deleteCallCount += 1
        deletedSessions.append(session)
        lastDeletedSession = session
        
        if let errorToThrow {
            throw errorToThrow
        }
    }
}

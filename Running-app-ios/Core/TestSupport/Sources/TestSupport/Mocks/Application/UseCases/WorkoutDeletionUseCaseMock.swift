//
//  WorkoutDeletionUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Domain
import Application

public actor WorkoutDeletionUseCaseMock {
    
    // MARK: - Tracking
    public private(set) var deleteCallCount = 0
    public private(set) var deletedSessions: [WorkoutSession] = []
    public private(set) var lastDeletedSession: WorkoutSession?
    
    // MARK: - Stubbing
    public var errorToThrow: Error?
    
    public init() {}
    
    public func delete(_ session: WorkoutSession) async throws {
        deleteCallCount += 1
        deletedSessions.append(session)
        lastDeletedSession = session
        
        if let errorToThrow {
            throw errorToThrow
        }
    }
}

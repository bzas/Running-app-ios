//
//  SessionImportUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Domain
import Application

public actor SessionImportUseCaseMock {
    
    // MARK: - Tracking
    public private(set) var fetchAllCallCount = 0
    public private(set) var fetchSessionCallCount = 0
    public private(set) var lastFetchedSessionId: UUID?
    
    // MARK: - Stubbing
    public var fetchAllResult: [WorkoutSession] = []
    public var fetchSessionResult: WorkoutSession?
    public var errorToThrow: Error?
    
    public init() {}
    
    public func fetchAllSessions() async throws -> [WorkoutSession] {
        fetchAllCallCount += 1
        
        if let errorToThrow {
            throw errorToThrow
        }
        
        return fetchAllResult
    }
    
    public func fetchSession(with sessionId: UUID) async throws -> WorkoutSession {
        fetchSessionCallCount += 1
        lastFetchedSessionId = sessionId
        
        if let errorToThrow {
            throw errorToThrow
        }
        
        if let fetchSessionResult {
            return fetchSessionResult
        }
        
        throw DatabaseMockError.sessionNotFound
    }
}

//
//  SessionImportUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Domain
import Application

public actor SessionImportUseCaseMock: SessionImportUseCaseProtocol {
    
    // MARK: - Tracking
    
    public private(set) var fetchAllCallCount = 0
    public private(set) var fetchAllPagedCallCount = 0
    public private(set) var fetchSessionCallCount = 0
    public private(set) var lastFetchedSessionId: UUID?
    public private(set) var lastFetchAllPage: Int?
    public private(set) var lastFetchAllPageSize: Int?
    public let repository: WorkoutRepositoryProtocol
    
    // MARK: - Stubbing
    
    public var fetchAllResult: [WorkoutSession] = []
    public var fetchAllPagedResults: [Int: [WorkoutSession]] = [:]
    public var fetchSessionResult: WorkoutSession?
    public var errorToThrow: Error?
    
    public init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }

    public func setFetchAllResult(_ sessions: [WorkoutSession]) {
        fetchAllResult = sessions
    }

    public func setFetchAllPagedResult(page: Int, sessions: [WorkoutSession]) {
        fetchAllPagedResults[page] = sessions
    }

    public func setFetchSessionResult(_ session: WorkoutSession?) {
        fetchSessionResult = session
    }

    public func setErrorToThrow(_ error: Error?) {
        errorToThrow = error
    }
    
    public func fetchAllSessions(lightWeight: Bool) async throws -> [WorkoutSession] {
        fetchAllCallCount += 1
        
        if let errorToThrow {
            throw errorToThrow
        }
        
        return fetchAllResult
    }

    public func fetchAllSessions(lightWeight: Bool, page: Int, pageSize: Int) async throws -> [WorkoutSession] {
        fetchAllPagedCallCount += 1
        lastFetchAllPage = page
        lastFetchAllPageSize = pageSize

        if let errorToThrow {
            throw errorToThrow
        }

        if let pagedResult = fetchAllPagedResults[page] {
            return pagedResult
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

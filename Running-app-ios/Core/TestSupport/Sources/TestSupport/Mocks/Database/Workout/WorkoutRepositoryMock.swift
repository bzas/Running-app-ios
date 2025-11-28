//
//  WorkoutRepository+Mock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Domain

public actor WorkoutRepositoryMock: WorkoutRepositoryProtocol {
    
    public private(set) var savedSessions: [WorkoutSession] = []
    public private(set) var updatedPhotosSessions: [WorkoutSession] = []
    public private(set) var deletedSessions: [WorkoutSession] = []
    private var fetchAllResult: [WorkoutSession] = []

    public init() {}

    public func updatePhotos(_ session: WorkoutSession) async throws {
        updatedPhotosSessions.append(session)
    }
    
    public func save(_ session: WorkoutSession) async throws {
        savedSessions.append(session)
    }
    
    public func fetchAll() async throws -> [WorkoutSession] {
        fetchAllResult
    }
    
    public func delete(_ session: WorkoutSession) async throws {
        deletedSessions.append(session)
    }

    public func setFetchAllResult(_ sessions: [WorkoutSession]) {
        fetchAllResult = sessions
    }
}

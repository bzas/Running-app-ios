//
//  WorkoutRepository+Mock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Domain
import Foundation

public actor WorkoutRepositoryMock: WorkoutRepositoryProtocol {
    
    public private(set) var savedSessions: [WorkoutSession] = []
    public private(set) var updatedPhotosSessions: [WorkoutSession] = []
    public private(set) var deletedSessions: [WorkoutSession] = []
    public private(set) var deletedPhotos: [SessionPhoto] = []
    private var fetchAllResult: [WorkoutSession] = []
    private var fetchAllPhotosResult: [SessionPhoto] = []
    private var fetchSessionResult: WorkoutSession?
    private var fetchSessionError: Error?

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
    
    public func fetchSession(with sessionId: UUID) async throws -> WorkoutSession {
        if let fetchSessionError {
            throw fetchSessionError
        }
        
        if let fetchSessionResult {
            return fetchSessionResult
        }
        
        guard let session = fetchAllResult.first(where: { $0.id == sessionId }) else {
            throw DatabaseMockError.sessionNotFound
        }
        
        return session
    }
    
    public func delete(_ session: WorkoutSession) async throws {
        deletedSessions.append(session)
    }
    
    public func fetchAllPhotos() async throws -> [SessionPhoto] {
        fetchAllPhotosResult
    }

    public func setFetchAllResult(_ sessions: [WorkoutSession]) {
        fetchAllResult = sessions
    }
    
    public func setFetchSessionResult(_ session: WorkoutSession?) {
        fetchSessionResult = session
    }
    
    public func setFetchSessionError(_ error: Error?) {
        fetchSessionError = error
    }
    
    public func setFetchAllPhotosResult(_ photos: [SessionPhoto]) {
        fetchAllPhotosResult = photos
    }
    
    public func deletePhoto(_ photo: SessionPhoto) async throws {
        deletedPhotos.append(photo)
    }
}

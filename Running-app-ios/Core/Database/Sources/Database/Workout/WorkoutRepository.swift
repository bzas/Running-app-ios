//
//  WorkoutRepository.swift
//  Domain
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import SwiftData
import Domain
import Foundation

@ModelActor
public actor WorkoutRepository: WorkoutRepositoryProtocol {
    
    public func save(_ session: WorkoutSession) async throws {
        let model = try WorkoutSessionDataModel(from: session)
        modelContext.insert(model)
        try modelContext.save()
    }
    
    public func fetchAll() async throws -> [WorkoutSession] {
        let descriptor = FetchDescriptor<WorkoutSessionDataModel>(
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
        )
        
        let models = try modelContext.fetch(descriptor)
        return try models.map { try $0.toDomain() }
    }
    
    public func updatePhotos(_ session: WorkoutSession) async throws {
        guard let model = try getSessionDataModel(for: session) else { return }
        model.photos = session.photos.map { SessionPhotoDataModel(from: $0) }
        try modelContext.save()
    }
    
    public func delete(_ session: WorkoutSession) async throws {
        guard let model = try getSessionDataModel(for: session) else { return }
        modelContext.delete(model)
        try modelContext.save() 
    }
    
    public func fetchAllPhotos() async throws -> [SessionPhoto] {
        let descriptor = FetchDescriptor<WorkoutSessionDataModel>(
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
        )

        let sessions = try modelContext.fetch(descriptor)
        let photos = sessions.flatMap(\.photos)
        return photos.map { $0.toDomain() }
    }
    
    public func deletePhoto(_ photo: SessionPhoto) async throws {
        let descriptor = FetchDescriptor<WorkoutSessionDataModel>()
        let sessions = try modelContext.fetch(descriptor)
        let photoId = photo.id
        
        guard let session = sessions.first(where: {
            $0.photos.contains { $0.id == photoId }
        }) else { return }
        
        session.photos.removeAll { $0.id == photoId }
        try modelContext.save()
    }
    
    public func fetchSession(with sessionId: UUID) async throws -> WorkoutSession {
        let descriptor = FetchDescriptor<WorkoutSessionDataModel>(
            predicate: #Predicate { $0.id == sessionId }
        )
        
        guard let model = try modelContext.fetch(descriptor).first else {
            throw DatabaseError.sessionNotFound
        }
        
        return try model.toDomain()
    }
}

// MARK: - Private methods

private extension WorkoutRepository {
    
    func getSessionDataModel(for session: WorkoutSession) throws -> WorkoutSessionDataModel? {
        let sessionId = session.id
        
        let descriptor = FetchDescriptor<WorkoutSessionDataModel>(
            predicate: #Predicate { $0.id == sessionId }
        )
        
        let results = try modelContext.fetch(descriptor)
        return results.first
    }
}

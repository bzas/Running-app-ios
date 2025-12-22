//
//  WorkoutRepositoryTests.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import SwiftData
import Foundation
import TestSupport
import Domain
@testable import Database

struct WorkoutRepositoryTests {

    @Test func testSave() async throws {
        let (repository, _) = try makeRepository()
        let session = WorkoutSession.mock
        
        try await repository.save(session)
        let fetched = try await repository.fetchAll(lightWeight: false)
        
        #expect(fetched.count == 1)
        #expect(fetched.first?.id == session.id)
    }
    
    @Test func testFetchAll() async throws {
        let (repository, _) = try makeRepository()
        let sessions = [WorkoutSession.mock, WorkoutSession.mock]
        
        for session in sessions {
            try await repository.save(session)
        }
        
        let fetched = try await repository.fetchAll(lightWeight: false)
        
        #expect(fetched.count == sessions.count)
    }
    
    @Test func testFetchAllLightWeight() async throws {
        let (repository, _) = try makeRepository()
        let sessions = [WorkoutSession.lightWeightMock, WorkoutSession.lightWeightMock]
        
        for session in sessions {
            try await repository.save(session)
        }
        
        let fetched = try await repository.fetchAll(lightWeight: false)
        
        #expect(fetched.count == sessions.count)
        #expect(fetched.first?.sessionTrackPoints.isEmpty == true)
    }
    
    @Test func testUpdatePhotos() async throws {
        let (repository, container) = try makeRepository()
        var session = WorkoutSession.mock
        try await repository.save(session)
        
        let newPhoto = SessionPhoto(data: Data("new-photo".utf8))
        session.photos = [newPhoto]
        
        try await repository.updatePhotos(session)
        
        let descriptor = FetchDescriptor<WorkoutSessionDataModel>()
        let storedPhotoIds: [UUID] = try await MainActor.run {
            let models = try container.mainContext.fetch(descriptor)
            return models.first?.photos.map(\.id) ?? []
        }
        
        #expect(storedPhotoIds.count == 1)
        #expect(storedPhotoIds.first == newPhoto.id)
    }
    
    @Test func testDelete() async throws {
        let (repository, _) = try makeRepository()
        let model = WorkoutSession.mock
        
        try await repository.save(model)
        
        try await repository.delete(model)
        let fetched = try await repository.fetchAll(lightWeight: false)
        
        #expect(fetched.count == 0)
    }
    
    @Test func testFetchAllPhotos() async throws {
        let (repository, _) = try makeRepository()
        
        let firstPhoto = SessionPhoto(data: Data("photo-1".utf8))
        let secondPhoto = SessionPhoto(data: Data("photo-2".utf8))
        
        var firstSession = WorkoutSession.mock
        firstSession.photos = [firstPhoto]
        
        var secondSession = WorkoutSession.mock
        secondSession.photos = [secondPhoto]
        
        try await repository.save(firstSession)
        try await repository.save(secondSession)
        
        let fetchedPhotos = try await repository.fetchAllPhotos()
        
        #expect(fetchedPhotos.count == 2)
        #expect(fetchedPhotos.contains { $0.id == firstPhoto.id })
        #expect(fetchedPhotos.contains { $0.id == secondPhoto.id })
    }
    
    @Test func testDeletePhoto() async throws {
        let (repository, container) = try makeRepository()
        
        let photoToDelete = SessionPhoto(data: Data("photo-to-delete".utf8))
        let remainingPhoto = SessionPhoto(data: Data("photo-to-keep".utf8))
        
        var session = WorkoutSession.mock
        session.photos = [photoToDelete, remainingPhoto]
        
        try await repository.save(session)
        
        try await repository.deletePhoto(photoToDelete)
        
        let descriptor = FetchDescriptor<WorkoutSessionDataModel>()
        let storedPhotoIds: [UUID] = try await MainActor.run {
            let models = try container.mainContext.fetch(descriptor)
            return models.first?.photos.map(\.id) ?? []
        }
        
        #expect(storedPhotoIds.count == 1)
        #expect(storedPhotoIds.first == remainingPhoto.id)
    }
}

// MARK: - Helpers

private extension WorkoutRepositoryTests {
    
    func makeRepository() throws -> (WorkoutRepository, ModelContainer) {
        let schema = Schema([
            WorkoutSessionDataModel.self,
            SessionPhotoDataModel.self,
            WorkoutSessionTrackPointDataModel.self
        ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [config])
        let repository = WorkoutRepository(modelContainer: container)
        return (repository, container)
    }
}

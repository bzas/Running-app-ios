//
//  UpdateGalleryUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Domain
import TestSupport
@testable import Application
import Foundation

struct UpdateGalleryUseCaseTests {

    @Test func testUpdatePhotos() async throws {
        let repository = WorkoutRepositoryMock()
        let useCase = UpdateGalleryUseCase(repository: repository)
        let session = WorkoutSession.mock

        try await useCase.updatePhotos(session)

        let updated = await repository.updatedPhotosSessions
        #expect(updated.count == 1)
        #expect(updated.first?.id == session.id)
    }
    
    @Test func testDeletePhoto() async throws {
        let repository = WorkoutRepositoryMock()
        let useCase = UpdateGalleryUseCase(repository: repository)
        let photo = SessionPhoto(data: Data("photo".utf8))
        
        try await useCase.deletePhoto(photo)
        
        let deletedPhotos = await repository.deletedPhotos
        #expect(deletedPhotos.count == 1)
        #expect(deletedPhotos.first?.id == photo.id)
    }
}

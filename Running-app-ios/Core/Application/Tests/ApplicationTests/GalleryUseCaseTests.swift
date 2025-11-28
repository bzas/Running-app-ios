//
//  GalleryUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Domain
import TestSupport
@testable import Application

struct GalleryUseCaseTests {

    @Test func testUpdatePhotos() async throws {
        let repository = WorkoutRepositoryMock()
        let useCase = GalleryUseCase(repository: repository)
        let session = WorkoutSession.mock

        try await useCase.updatePhotos(session)

        let updated = await repository.updatedPhotosSessions
        #expect(updated.count == 1)
        #expect(updated.first?.id == session.id)
    }
}

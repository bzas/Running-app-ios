//
//  Untitled.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//

import Testing
import Domain
import TestSupport
@testable import Application
import Foundation

struct GetGalleryUseCaseTests {

    @Test func testGetAllPhotos() async throws {
        let repository = WorkoutRepositoryMock()
        let expectedPhotos = [
            SessionPhoto.mock,
            SessionPhoto(data: Data("second-photo".utf8))
        ]
        await repository.setFetchAllPhotosResult(expectedPhotos)
        let useCase = GetGalleryUseCase(repository: repository)

        let photos = try await useCase.getAllPhotos()

        #expect(photos.count == expectedPhotos.count)
        #expect(photos.first?.id == expectedPhotos.first?.id)
    }
}

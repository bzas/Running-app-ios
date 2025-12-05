//
//  UpdateGalleryUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 27/11/25.
//

import Domain

public protocol UpdateGalleryUseCaseProtocol: Sendable {
    func updatePhotos(_ model: WorkoutSession) async throws
    func deletePhoto(_ photo: SessionPhoto) async throws
}

actor UpdateGalleryUseCase: UpdateGalleryUseCaseProtocol {
    
    private let repository: WorkoutRepositoryProtocol
    
    init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    func updatePhotos(_ model: WorkoutSession) async throws {
        try await repository.updatePhotos(model)
    }
    
    func deletePhoto(_ photo: SessionPhoto) async throws {
        try await repository.deletePhoto(photo)
    }
}

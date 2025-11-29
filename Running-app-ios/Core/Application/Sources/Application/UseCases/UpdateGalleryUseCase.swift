//
//  UpdateGalleryUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 27/11/25.
//

import Domain

public actor UpdateGalleryUseCase {
    
    private let repository: WorkoutRepositoryProtocol
    
    public init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    public func updatePhotos(_ model: WorkoutSession) async throws {
        try await repository.updatePhotos(model)
    }
    
    public func deletePhoto(_ photo: SessionPhoto) async throws {
        try await repository.deletePhoto(photo)
    }
}

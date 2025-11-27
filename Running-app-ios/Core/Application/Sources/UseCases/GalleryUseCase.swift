//
//  GalleryUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 27/11/25.
//

import Domain

public actor GalleryUseCase {
    
    private let repository: WorkoutRepositoryProtocol
    
    public init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    public func updatePhotos(_ model: WorkoutSession) async throws {
        try await repository.updatePhotos(model)
    }
}

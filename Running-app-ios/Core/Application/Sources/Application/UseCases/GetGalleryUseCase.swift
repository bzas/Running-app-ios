//
//  GetGalleryUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//

import Domain

public actor GetGalleryUseCase {
    
    private let repository: WorkoutRepositoryProtocol
    
    public init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getAllPhotos() async throws -> [SessionPhoto] {
        try await repository.fetchAllPhotos()
    }
}

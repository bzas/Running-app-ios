//
//  GetGalleryUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//

import Domain

public protocol GetGalleryUseCaseProtocol: Sendable {
    func getAllPhotos() async throws -> [SessionPhoto]
}

actor GetGalleryUseCase: GetGalleryUseCaseProtocol {
    
    private let repository: WorkoutRepositoryProtocol
    
    init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    func getAllPhotos() async throws -> [SessionPhoto] {
        try await repository.fetchAllPhotos()
    }
}

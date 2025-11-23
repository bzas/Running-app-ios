//
//  GarminImporter.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Database
import Domain
import GarminKit
import Foundation

public actor GarminImportUseCase {
    
    private let garminService: GarminServiceProtocol
    private let repository: WorkoutRepositoryProtocol

    public init(
        garminService: GarminServiceProtocol,
        repository: WorkoutRepositoryProtocol
    ) {
        self.garminService = garminService
        self.repository = repository
    }
    
    public func importSession(from file: URL) async throws {
        _ = file.startAccessingSecurityScopedResource()
        let data = try Data(contentsOf: file)
        file.stopAccessingSecurityScopedResource()
        
        let workoutSession = try await garminService.fetchFitFile(from: data)
        try await repository.save(workoutSession)
    }
}

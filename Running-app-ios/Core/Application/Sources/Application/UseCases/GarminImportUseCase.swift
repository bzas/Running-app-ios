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

public protocol GarminImportUseCaseProtocol: Sendable {
    func importSession(from file: URL) async throws
}

actor GarminImportUseCase: GarminImportUseCaseProtocol {
    
    private let garminService: GarminServiceProtocol
    private let repository: WorkoutRepositoryProtocol

    init(
        garminService: GarminServiceProtocol,
        repository: WorkoutRepositoryProtocol
    ) {
        self.garminService = garminService
        self.repository = repository
    }
    
    func importSession(from file: URL) async throws {
        let didAccess = file.startAccessingSecurityScopedResource()
        guard didAccess else {
            throw CocoaError(.fileReadNoPermission)
        }
        
        defer {
            file.stopAccessingSecurityScopedResource()
        }
        
        let data = try Data(contentsOf: file)
        let workoutSession = try await garminService.fetchFitFile(from: data)
        try await repository.save(workoutSession)
    }
}

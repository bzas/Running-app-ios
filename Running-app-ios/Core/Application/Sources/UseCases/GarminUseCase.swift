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

public actor GarminUseCase {
    
    private let garminService: GarminServiceProtocol
    private let repository: WorkoutRepositoryProtocol

    public init(
        garminService: GarminServiceProtocol,
        repository: WorkoutRepositoryProtocol
    ) {
        self.garminService = garminService
        self.repository = repository
    }
    
    public func fetch(from file: URL) async -> WorkoutSession? {
        do {
            _ = file.startAccessingSecurityScopedResource()
            let data = try Data(contentsOf: file)
            file.stopAccessingSecurityScopedResource()
            
            let sessionDataModel = try await garminService.fetchFitFile(from: data)
            return sessionDataModel?.toDomain()
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

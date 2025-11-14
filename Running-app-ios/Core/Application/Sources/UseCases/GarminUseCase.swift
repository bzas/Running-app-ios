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
    
    public func fetch(from data: Data) async -> WorkoutSession? {
        guard let sessionDataModel = try? await garminService.fetchFitFile(from: data) else { return nil }
        return sessionDataModel.toDomain()
    }
}

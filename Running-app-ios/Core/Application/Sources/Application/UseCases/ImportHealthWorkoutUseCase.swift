//
//  GetDetailHealthWorkoutUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import Domain
import HealthKitService

public protocol ImportHealthWorkoutUseCaseProtocol: Sendable {
    func fetchCompleteWorkout(lightWeightSession: WorkoutSession) async throws
}

public actor ImportHealthWorkoutUseCase: ImportHealthWorkoutUseCaseProtocol {
    
    private let healthKitService: HealthKitServiceProtocol
    private let repository: WorkoutRepositoryProtocol
    
    init(
        healthKitService: HealthKitServiceProtocol,
        repository: WorkoutRepositoryProtocol
    ) {
        self.healthKitService = healthKitService
        self.repository = repository
    }

    public func fetchCompleteWorkout(lightWeightSession: WorkoutSession) async throws {
        let session = try await healthKitService.fetchFullWorkout(lightWeightSession: lightWeightSession)
        try await repository.save(session)
    }
}

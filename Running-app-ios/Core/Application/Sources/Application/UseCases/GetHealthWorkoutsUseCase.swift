//
//  GetHealthWorkoutsUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import HealthKitService
import Domain

public protocol GetHealthWorkoutsUseCaseProtocol: Sendable {
    func fetchWorkouts() async throws -> [WorkoutSession]
}

actor GetHealthWorkoutsUseCase: GetHealthWorkoutsUseCaseProtocol {
    
    private let healthKitService: HealthKitServiceProtocol
    
    init(healthKitService: HealthKitServiceProtocol) {
        self.healthKitService = healthKitService
    }
    
    func fetchWorkouts() async throws -> [WorkoutSession] {
        try await healthKitService.fetchWorkouts(limit: 1000)
    }
}

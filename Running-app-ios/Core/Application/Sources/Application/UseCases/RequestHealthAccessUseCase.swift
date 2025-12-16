//
//  RequestHealthAccessUseCase.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 16/12/25.
//

import HealthKitService

public protocol RequestHealthAccessUseCaseProtocol: Sendable {
    func requestUserPermission() async throws
}

actor RequestHealthAccessUseCase: RequestHealthAccessUseCaseProtocol {
    
    private let healthKitService: HealthKitServiceProtocol
    
    init(healthKitService: HealthKitServiceProtocol) {
        self.healthKitService = healthKitService
    }
    
    func requestUserPermission() async throws {
        try await healthKitService.requestUserPermission()
    }
}

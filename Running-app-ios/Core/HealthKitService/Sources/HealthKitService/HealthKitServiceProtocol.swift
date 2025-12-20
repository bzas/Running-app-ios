//
//  HealthKitServiceProtocol.swift
//  HealthKitService
//
//  Created by Alfonso Boizas Crespo on 16/12/25.
//

import Domain

public protocol HealthKitServiceProtocol: Sendable {
    func requestUserPermission() async throws
    func fetchWorkouts(limit: Int) async throws -> [WorkoutSession]
}

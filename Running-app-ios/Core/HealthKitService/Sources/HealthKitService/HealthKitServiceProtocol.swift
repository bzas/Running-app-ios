//
//  HealthKitServiceProtocol.swift
//  HealthKitService
//
//  Created by Alfonso Boizas Crespo on 16/12/25.
//

public protocol HealthKitServiceProtocol: Sendable {
    func requestUserPermission() async throws
}

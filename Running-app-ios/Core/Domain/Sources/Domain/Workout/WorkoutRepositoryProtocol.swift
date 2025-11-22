//
//  WorkoutRepositoryProtocol.swift
//  Domain
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation

public protocol WorkoutRepositoryProtocol: Sendable {
    
    func save(_ session: WorkoutSession) async throws
    func fetchAll() async throws -> [WorkoutSession]
}

//
//  WorkoutRepositoryProtocol.swift
//  Domain
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation

public protocol WorkoutRepositoryProtocol: Sendable {
    
    func updatePhotos(_ session: WorkoutSession) async throws
    func save(_ session: WorkoutSession) async throws
    func fetchAll() async throws -> [WorkoutSession]
    func delete(_ session: WorkoutSession) async throws
}

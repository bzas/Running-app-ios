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
    func fetchAll(lightWeight: Bool) async throws -> [WorkoutSession]
    func fetchSession(with sessionId: UUID) async throws -> WorkoutSession
    func delete(_ session: WorkoutSession) async throws
    func fetchAllPhotos() async throws -> [SessionPhoto]
    func deletePhoto(_ photo: SessionPhoto) async throws
}

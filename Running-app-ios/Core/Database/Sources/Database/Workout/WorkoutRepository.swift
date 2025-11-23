//
//  WorkoutRepository.swift
//  Domain
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import SwiftData
import Domain
import Foundation

@ModelActor
public actor WorkoutRepository: WorkoutRepositoryProtocol {
    
    public func save(_ session: WorkoutSession) async throws {
        let model = try WorkoutSessionDataModel(from: session)
        modelContext.insert(model)
        try modelContext.save()
    }
    
    public func fetchAll() async throws -> [WorkoutSession] {
        let descriptor = FetchDescriptor<WorkoutSessionDataModel>(
            sortBy: [SortDescriptor(\.timestamp, order: .reverse)]
        )
        
        let models = try modelContext.fetch(descriptor)
        return try models.map { try $0.toDomain() }
    }
    
    public func updatePhotos(_ session: WorkoutSession) async throws {
        let sessionId = session.id
        
        let descriptor = FetchDescriptor<WorkoutSessionDataModel>(
            predicate: #Predicate { $0.id == sessionId }
        )
        
        let results = try modelContext.fetch(descriptor)
        guard let model = results.first else { return }
        model.photos = session.photos
        try modelContext.save()
    }
}

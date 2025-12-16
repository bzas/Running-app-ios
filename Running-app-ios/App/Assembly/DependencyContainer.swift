//
//  DependencyContainer.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import GarminKit
import Domain
import Database
import SwiftData
import HealthKitService

final class DependencyContainer {
    
    // MARK: - SwiftData container
    
    var modelContainer: ModelContainer = {
        let schema = Schema(
            [
                WorkoutSessionDataModel.self,
                UserDataModel.self
            ]
        )
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // MARK: - Repositories

    let workoutRepository: WorkoutRepositoryProtocol
    let userRepository: UserRepositoryProtocol
    
    // MARK: - Services
    
    let garminService: GarminServiceProtocol
    let healthKitService: HealthKitServiceProtocol
    
    init() {
        self.workoutRepository = WorkoutRepository(modelContainer: modelContainer)
        self.userRepository = UserRepository(modelContainer: modelContainer)
        self.garminService = GarminService()
        self.healthKitService = HealthKitService()
    }
}

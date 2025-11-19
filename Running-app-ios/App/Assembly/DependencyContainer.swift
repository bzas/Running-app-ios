//
//  DependencyContainer.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import GarminKit
import Domain
import Database

final class DependencyContainer {
    
    // MARK: - Repositories

    let workoutRepository: WorkoutRepositoryProtocol = WorkoutRepository()
    let userRepository: UserRepositoryProtocol = UserRepository()
    
    // MARK: - Services
    
    let garminService: GarminServiceProtocol = GarminService()
}

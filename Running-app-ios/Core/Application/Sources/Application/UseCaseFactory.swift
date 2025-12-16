//
//  UseCaseFactory.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Domain
import GarminKit
import HealthKitService

public struct UseCaseFactory {
    
    private let userRepository: UserRepositoryProtocol
    private let workoutRepository: WorkoutRepositoryProtocol
    private let garminService: GarminServiceProtocol
    private let healthKitService: HealthKitServiceProtocol
    
    public init(
        userRepository: UserRepositoryProtocol,
        workoutRepository: WorkoutRepositoryProtocol,
        garminService: GarminServiceProtocol,
        healthKitService: HealthKitServiceProtocol
    ) {
        self.userRepository = userRepository
        self.workoutRepository = workoutRepository
        self.garminService = garminService
        self.healthKitService = healthKitService
    }
    
    public func makeGarminImportUseCase() -> GarminImportUseCaseProtocol {
        GarminImportUseCase(
            garminService: garminService,
            repository: workoutRepository
        )
    }
    
    public func makeSessionImportUseCase() -> SessionImportUseCaseProtocol {
        SessionImportUseCase(
            repository: workoutRepository
        )
    }
    
    public func makeCreateUserUseCase() -> CreateUserUseCaseProtocol {
        CreateUserUseCase(
            repository: userRepository
        )
    }
    
    public func makeEditUserUseCase() -> EditUserUseCaseProtocol {
        EditUserUseCase(
            repository: userRepository
        )
    }
    
    public func makeGetUserUseCase() -> GetUserUseCaseProtocol {
        GetUserUseCase(
            repository: userRepository
        )
    }
    
    public func makeWorkoutDeletionUseCase() -> WorkoutDeletionUseCaseProtocol {
        WorkoutDeletionUseCase(
            repository: workoutRepository
        )
    }
    
    public func makeUpdateGalleryUseCase() -> UpdateGalleryUseCaseProtocol {
        UpdateGalleryUseCase(
            repository: workoutRepository
        )
    }
    
    public func makeGetGalleryUseCase() -> GetGalleryUseCaseProtocol {
        GetGalleryUseCase(
            repository: workoutRepository
        )
    }
    
    public func makeRequestHealthAccessUseCase() -> RequestHealthAccessUseCaseProtocol {
        RequestHealthAccessUseCase(
            healthKitService: healthKitService
        )
    }
}

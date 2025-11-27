//
//  AppAssembly.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Workouts
import Database
import Domain
import Application
import Launch
import Profile
import Search
import WorkoutDetail
import SwiftUI

@MainActor
final class AppAssembly {
    
    let container: DependencyContainer
    
    public init() {
        self.container = DependencyContainer()
    }
}

// MARK: - WorkoutsAssemblyProtocol conformance

extension AppAssembly: WorkoutsAssemblyProtocol {
    
    public func makeWorkoutsViewModel() -> WorkoutsViewModel {
        let garminUseCase = makeGarminUseCase()
        let sessionImportUseCase = makeSessionImportUseCase()
        let workoutDeletionUseCase = makeWorkoutDeletionUseCase()
        
        return WorkoutsViewModel(
            garminUseCase: garminUseCase,
            sessionImportUseCase: sessionImportUseCase,
            workoutDeletionUseCase: workoutDeletionUseCase
        )
    }
}

// MARK: - ProfileAssemblyProtocol conformance

extension AppAssembly: ProfileAssemblyProtocol {
    
    public func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel()
    }
}

// MARK: - LaunchAssemblyProtocol conformance

extension AppAssembly: LaunchAssemblyProtocol {
    
    public func makeLaunchViewModel() -> LaunchViewModel {
        let createUserUseCase = makeCreateUserUseCase()
        
        return LaunchViewModel(
            createUserUseCase: createUserUseCase
        )
    }
}

// MARK: - SearchAssemblyProtocol conformance

extension AppAssembly: SearchAssemblyProtocol {
    
    public func makeSearchViewModel() -> SearchViewModel {
        let sessionImportUseCase = makeSessionImportUseCase()

        return SearchViewModel(
            sessionImportUseCase: sessionImportUseCase
        )
    }
}

// MARK: - WorkoutDetailAssemblyProtocol conformance

extension AppAssembly: WorkoutDetailAssemblyProtocol {    
    
    public func makeWorkoutDetailViewModel(
        for session: WorkoutSession,
        onDismiss: @escaping () -> Void
    ) -> WorkoutDetailViewModel {
        let getUserUseCase = makeGetUserUseCase()
        let galleryUseCase = makeGalleryUseCase()

        return WorkoutDetailViewModel(
            session: session,
            getUserUseCase: getUserUseCase,
            galleryUseCase: galleryUseCase,
            onDismiss: onDismiss
        )
    }
}

// MARK: - Use Case creation

private extension AppAssembly {
    
    func makeGarminUseCase() -> GarminImportUseCase {
        GarminImportUseCase(
            garminService: container.garminService,
            repository: container.workoutRepository
        )
    }
    
    func makeSessionImportUseCase() -> SessionImportUseCase {
        SessionImportUseCase(
            repository: container.workoutRepository
        )
    }
    
    func makeCreateUserUseCase() -> CreateUserUseCase {
        CreateUserUseCase(
            repository: container.userRepository
        )
    }
    
    func makeGetUserUseCase() -> GetUserUseCase {
        GetUserUseCase(
            repository: container.userRepository
        )
    }
    
    func makeWorkoutDeletionUseCase() -> WorkoutDeletionUseCase {
        WorkoutDeletionUseCase(
            repository: container.workoutRepository
        )
    }
    
    func makeGalleryUseCase() -> GalleryUseCase {
        GalleryUseCase(
            repository: container.workoutRepository
        )
    }
}

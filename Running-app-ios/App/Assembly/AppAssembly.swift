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
import UserConfiguration
import Profile
import Search
import WorkoutDetail
import SwiftUI

@MainActor
final class AppAssembly {
    
    let container: DependencyContainer
    let useCaseFactory: UseCaseFactory
    
    init() {
        let container = DependencyContainer()
        self.container = container
        self.useCaseFactory = UseCaseFactory(
            userRepository: container.userRepository,
            workoutRepository: container.workoutRepository,
            garminService: container.garminService,
            healthKitService: container.healthKitService
        )
    }
}

// MARK: - WorkoutsAssemblyProtocol conformance

extension AppAssembly: WorkoutsAssemblyProtocol {
    
    public func makeWorkoutsViewModel() -> WorkoutsViewModel {
        let garminUseCase = useCaseFactory.makeGarminImportUseCase()
        let sessionImportUseCase = useCaseFactory.makeSessionImportUseCase()
        let workoutDeletionUseCase = useCaseFactory.makeWorkoutDeletionUseCase()
        let requestHealthAccessUseCase = useCaseFactory.makeRequestHealthAccessUseCase()
        
        return WorkoutsViewModel(
            garminUseCase: garminUseCase,
            sessionImportUseCase: sessionImportUseCase,
            workoutDeletionUseCase: workoutDeletionUseCase,
            requestHealthKitAccessUseCase: requestHealthAccessUseCase
        )
    }
    
    public func makeAppleHealthWorkoutsViewModel(
        delegate: AppleHealthImportDelegate?,
        alreadyImportedSessions: [UUID]
    ) -> AppleHealthWorkoutsViewModel {
        let getHealthWorkoutsUseCase = useCaseFactory.makeGetHealthWorkoutsUseCase()
        let importHealthWorkoutUseCaseProtocol = useCaseFactory.makeImportHealthWorkoutUseCase()
        
        return AppleHealthWorkoutsViewModel(
            getHealthWorkoutsUseCase: getHealthWorkoutsUseCase,
            importHealthWorkoutUseCase: importHealthWorkoutUseCaseProtocol,
            alreadyImportedSessions: alreadyImportedSessions,
            delegate: delegate
        )
    }
}

// MARK: - ProfileAssemblyProtocol conformance

extension AppAssembly: ProfileAssemblyProtocol {
    
    public func makeProfileViewModel() -> ProfileViewModel {
        let getGalleryUseCase = useCaseFactory.makeGetGalleryUseCase()
        let updateGalleryUseCase = useCaseFactory.makeUpdateGalleryUseCase()
        let getUserUseCase = useCaseFactory.makeGetUserUseCase()
        let sessionImportUseCase = useCaseFactory.makeSessionImportUseCase()

        return ProfileViewModel(
            getGalleryUseCase: getGalleryUseCase,
            updateGalleryUseCase: updateGalleryUseCase,
            getUserUseCase: getUserUseCase,
            sessionImportUseCase: sessionImportUseCase
        )
    }
}

// MARK: - UserConfigurationAssemblyProtocol conformance

extension AppAssembly: UserConfigurationAssemblyProtocol {
    
    public func makeUserConfigurationViewModel(
        savedUser: User?,
        completion: (() -> Void)?
    ) -> UserConfigurationViewModel {
        let createUserUseCase = useCaseFactory.makeCreateUserUseCase()
        let editUserUseCase = useCaseFactory.makeEditUserUseCase()
        
        return UserConfigurationViewModel(
            createUserUseCase: createUserUseCase,
            editUserUseCase: editUserUseCase,
            savedUser: savedUser,
            completion: completion
        )
    }
}

// MARK: - SearchAssemblyProtocol conformance

extension AppAssembly: SearchAssemblyProtocol {
    
    public func makeSearchViewModel() -> SearchViewModel {
        let sessionImportUseCase = useCaseFactory.makeSessionImportUseCase()

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
        let getUserUseCase = useCaseFactory.makeGetUserUseCase()
        let updateGalleryUseCase = useCaseFactory.makeUpdateGalleryUseCase()
        let sessionImportUseCase = useCaseFactory.makeSessionImportUseCase()

        return WorkoutDetailViewModel(
            session: session,
            getUserUseCase: getUserUseCase,
            updateGalleryUseCase: updateGalleryUseCase,
            sessionImportUseCase: sessionImportUseCase,
            onDismiss: onDismiss
        )
    }
}

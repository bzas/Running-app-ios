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
        let workoutsUseCase = makeWorkoutsUseCase()
        
        return WorkoutsViewModel(
            garminUseCase: garminUseCase,
            workoutsUseCase: workoutsUseCase
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
        let userUseCase = makeUserUseCase()
        
        return LaunchViewModel(
            useCase: userUseCase
        )
    }
}

// MARK: - SearchAssemblyProtocol conformance

extension AppAssembly: SearchAssemblyProtocol {
    
    public func makeSearchViewModel() -> SearchViewModel {
        let workoutsUseCase = makeWorkoutsUseCase()

        return SearchViewModel(
            workoutsUseCase: workoutsUseCase
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
    
    func makeWorkoutsUseCase() -> WorkoutsUseCase {
        WorkoutsUseCase(
            repository: container.workoutRepository
        )
    }
    
    func makeUserUseCase() -> UserUseCase {
        UserUseCase(
            repository: container.userRepository
        )
    }
}

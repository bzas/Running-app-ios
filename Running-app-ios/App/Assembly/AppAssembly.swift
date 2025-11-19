//
//  AppAssembly.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Workouts
import GarminKit
import Database
import Domain
import Application
import Launch
import Profile

@MainActor
public final class AppAssembly: WorkoutsAssemblyProtocol, ProfileAssemblyProtocol, LaunchAssemblyProtocol {
    
    let container = DependencyContainer()
        
    // MARK: - WorkoutsAssemblyProtocol conformance
    
    public func makeWorkoutsViewModel() -> WorkoutsViewModel {
        let garminUseCase = makeGarminUseCase()
        return WorkoutsViewModel(useCase: garminUseCase)
    }
    
    // MARK: - ProfileAssemblyProtocol conformance

    public func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel()
    }
    
    // MARK: - LaunchAssemblyProtocol conformance

    public func makeLaunchViewModel() -> LaunchViewModel {
        let userUseCase = makeUserUseCase()
        return LaunchViewModel(useCase: userUseCase)
    }
}

// MARK: - Use Case creation

private extension AppAssembly {
    
    func makeGarminUseCase() -> GarminUseCase {
        GarminUseCase(
            garminService: container.garminService,
            repository: container.workoutRepository
        )
    }
    
    func makeUserUseCase() -> UserUseCase {
        UserUseCase(repository: container.userRepository)
    }
}

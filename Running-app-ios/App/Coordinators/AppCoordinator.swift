//
//  AppCoordinator.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftData
import SwiftUI
import Workouts
import Localization
import Combine
import Profile
import UserConfiguration
import Search
import Database

@MainActor
final class AppCoordinator: ObservableObject {
    
    // MARK: - App assembler
    
    var assembly: AppAssembly!
    
    // MARK: - Child coordinators
    
    var workoutsCoordinator: WorkoutsCoordinator!
    var profileCoordinator: ProfileCoordinator!
    var userConfigurationCoordinator: UserConfigurationCoordinator!
    var searchCoordinator: SearchCoordinator!
        
    init() {
        assembly = AppAssembly()
        workoutsCoordinator = WorkoutsCoordinator(assembly: assembly)
        profileCoordinator = ProfileCoordinator(assembly: assembly)
        userConfigurationCoordinator = UserConfigurationCoordinator(assembly: assembly)
        searchCoordinator = SearchCoordinator(assembly: assembly)
    }
    
    @ViewBuilder
    func rootView() -> some View {
        AppRootView(coordinator: self)
    }
}

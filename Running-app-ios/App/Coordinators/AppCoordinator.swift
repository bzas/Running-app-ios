//
//  AppCoordinator.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI
import Workouts
import Localization
import Combine
import Profile
import Launch
import Search

@MainActor
final class AppCoordinator: ObservableObject {
    
    let assembly: AppAssembly
    
    var workoutsCoordinator: WorkoutsCoordinator
    var profileCoordinator: ProfileCoordinator
    var launchCoordinator: LaunchCoordinator
    var searchCoordinator: SearchCoordinator

    init() {
        assembly = AppAssembly()
        workoutsCoordinator = WorkoutsCoordinator(assembly: assembly)
        profileCoordinator = ProfileCoordinator(assembly: assembly)
        launchCoordinator = LaunchCoordinator(assembly: assembly)
        searchCoordinator = SearchCoordinator(assembly: assembly)
    }
        
    @ViewBuilder
    func rootView() -> some View {
        TabView {
            Tab(Localizables.Workouts.title, systemImage: "house") {
                workoutsCoordinator.rootView()
            }

            Tab(Localizables.Profile.title, systemImage: "chart.bar.xaxis.ascending") {
                profileCoordinator.rootView()
            }
            
            Tab(role: .search) {
                searchCoordinator.rootView()
            }
        }
    }
}

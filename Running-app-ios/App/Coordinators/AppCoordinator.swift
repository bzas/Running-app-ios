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

@MainActor
final class AppCoordinator: ObservableObject {
    
    let assembly: AppAssembly
    
    var workoutsCoordinator: WorkoutsCoordinator
    var profileCoordinator: ProfileCoordinator
    var launchCoordinator: LaunchCoordinator

    init() {
        assembly = AppAssembly()
        workoutsCoordinator = WorkoutsCoordinator(assembly: assembly)
        profileCoordinator = ProfileCoordinator(assembly: assembly)
        launchCoordinator = LaunchCoordinator(assembly: assembly)
    }
    
    @ViewBuilder
    func rootView() -> some View {
        TabView {
            workoutsCoordinator.rootView()
                .tabItem {
                    Image(systemName: "house")
                    Text(Localizables.Workouts.title)
                }
            
            profileCoordinator.rootView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis.ascending")
                    Text(Localizables.Profile.title)
                }
        }
    }
}

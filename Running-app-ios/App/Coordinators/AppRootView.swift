//
//  AppRootView.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 24/11/25.
//

import SwiftUI
import Localization
import Workouts
import Profile
import Search
import Launch

struct AppRootView: View {
    
    @ObservedObject var coordinator: AppCoordinator
    @AppStorage("userDataNeeded") var userDataNeeded: Bool = true

    var body: some View {
        TabView {
            Tab(Localizables.Workouts.title, systemImage: "house") {
                coordinator.workoutsCoordinator.rootView()
            }
            
            Tab(Localizables.Profile.title, systemImage: "chart.bar.xaxis.ascending") {
                coordinator.profileCoordinator.rootView()
            }
            
            Tab(role: .search) {
                coordinator.searchCoordinator.rootView()
            }
        }
        .sheet(isPresented: $userDataNeeded) {
            coordinator.launchCoordinator.rootView()
        }
    }
}

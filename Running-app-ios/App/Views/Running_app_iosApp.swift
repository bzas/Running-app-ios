//
//  Running_app_iosApp.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 8/11/25.
//

import SwiftUI
import SwiftData
import Workouts
import Launch
import Database

@main
struct Running_app_iosApp: App {
    
    @StateObject var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.rootView()
        }
        .modelContainer(coordinator.assembly.container.modelContainer)
    }
}

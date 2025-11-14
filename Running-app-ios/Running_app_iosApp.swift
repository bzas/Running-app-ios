//
//  Running_app_iosApp.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 8/11/25.
//

import SwiftUI
import SwiftData
import Workouts
import GarminKit
import Application
import Database

@main
struct Running_app_iosApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject var workoutsViewModel: WorkoutsViewModel
    
    init() {
        let workoutsViewModel = WorkoutsViewModel(useCase: Self.makeGarminUseCase())
        _workoutsViewModel = StateObject(wrappedValue: workoutsViewModel)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(workoutsViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
    
    static func makeGarminUseCase() -> GarminUseCase {
        GarminUseCase(
            garminService: GarminService(),
            repository: WorkoutRepository()
        )
    }
}

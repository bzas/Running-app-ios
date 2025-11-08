//
//  Running_app_iosApp.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 8/11/25.
//

import SwiftUI
import SwiftData

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

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}

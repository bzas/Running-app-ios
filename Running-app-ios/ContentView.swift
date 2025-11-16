//
//  ContentView.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 8/11/25.
//

import SwiftUI
import Profile
import Localization
import Workouts

struct ContentView: View {

    var body: some View {
        TabView {
            WorkoutsView()
                .tabItem {
                    Image(systemName: "house")
                    Text(Localizables.Workouts.title)
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis.ascending")
                    Text(Localizables.Profile.title)
                }
        }
    }
}

#Preview {
    ContentView()
}

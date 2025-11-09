//
//  ContentView.swift
//  Running-app-ios
//
//  Created by Alfonso Boizas Crespo on 8/11/25.
//

import SwiftUI
import Home
import Profile
import Localization
import Workouts

struct ContentView: View {

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text(Localizables.Home.tabTitle)
                }
            
            WorkoutsView()
                .tabItem {
                    Image(systemName: "figure.run.square.stack")
                    Text(Localizables.Workouts.tabTitle)
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis.ascending")
                    Text(Localizables.Profile.tabTitle)
                }
        }
    }
}

#Preview {
    ContentView()
}

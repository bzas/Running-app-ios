//
//  ActivitySummaryView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI
import Common

struct ActivitySummaryView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text("Kilometers you run")
                    .font(.footnote)
                
                Text(DataFormatter.distance(viewModel.totalKilometers))
                    .font(.title)
                    .fontWeight(.heavy)
            }
            Spacer()
            VStack {
                Text("Workouts registered")
                    .font(.footnote)
                
                Text("\(viewModel.totalWorkouts)")
                    .font(.title)
                    .fontWeight(.heavy)
            }
            Spacer()
        }
        .padding(.bottom)
    }
}

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
            VStack(spacing: 8) {
                Text("Kilometers you run")
                    .font(.footnote)
                
                HStack(alignment: .bottom, spacing: 2) {
                    Text("\(Int(viewModel.totalKilometers))")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    Text("km")
                        .baselineOffset(5)
                }
            }
            Spacer()
            VStack(spacing: 8) {
                Text("Workouts registered")
                    .font(.footnote)
                
                Text("\(viewModel.totalWorkouts)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
            Spacer()
        }
        .padding(.bottom)
    }
}

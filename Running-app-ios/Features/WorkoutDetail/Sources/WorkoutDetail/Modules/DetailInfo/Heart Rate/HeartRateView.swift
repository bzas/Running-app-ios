//
//  HeartRateView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import SwiftUI
import Domain

struct HeartRateView: View {

    @EnvironmentObject var viewModel: WorkoutDetailViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Heart Rate")
                    .font(.title2)
                Spacer()
            }
            
            VStack(spacing: 32) {
                HeartRateChartView()
                    .environmentObject(viewModel)

                HeartRateSummaryView()
                    .environmentObject(viewModel)

                HeartRateZonesView()
                    .environmentObject(viewModel)
            }
        }
    }
}

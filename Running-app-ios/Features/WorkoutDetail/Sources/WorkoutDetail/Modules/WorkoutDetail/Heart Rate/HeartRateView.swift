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
        VStack(alignment: .leading, spacing: 24) {
            Text("Heart Rate")
                .font(.title2)
                .fontWeight(.semibold)

            VStack(spacing: 32) {
                HeartRateChartView()
                    .environmentObject(viewModel)
                
                HeartRateSummaryView()
                    .environmentObject(viewModel)
                
                HeartRateZonesView()
                    .environmentObject(viewModel)
            }
            
            Spacer()
        }
        .padding(32)
        .presentationBackgroundInteraction(.enabled)
        .presentationDetents([.fraction(0.65)])
    }
}

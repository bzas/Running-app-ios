//
//  WorkoutDetailInfoView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 16/11/25.
//

import SwiftUI
import Domain

struct WorkoutDetailInfoView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                Text(viewModel.session.name)
                    .font(.title)
                
                WorkoutSummaryView(session: viewModel.session)
                    .padding(.horizontal, 8)
                
                LazyVStack(spacing: 48) {
                    PaceView()
                        .environmentObject(viewModel)
                    
                    HeartRateView()
                        .environmentObject(viewModel)

//                    HeartRateZonesView()
//                        .environmentObject(viewModel)
                }
            }
            .padding(32)
        }
        .scrollIndicators(.hidden)
        .presentationBackgroundInteraction(.enabled)
        .presentationDetents([.fraction(0.35), .large])
    }
}

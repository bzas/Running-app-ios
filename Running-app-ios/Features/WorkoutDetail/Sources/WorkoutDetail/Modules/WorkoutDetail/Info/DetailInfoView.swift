//
//  DetailInfoView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 16/11/25.
//

import SwiftUI
import Domain
import Common

struct DetailInfoView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(viewModel.session.name)
                .font(.title2)
                .fontWeight(.semibold)
            
            WorkoutSummaryView(
                paceInSeconds: viewModel.session.paceInSeconds,
                distance: viewModel.session.distanceInKm,
                time: viewModel.session.totalTime
            )
            .padding(.horizontal, 8)
            
            PaceView()
                .environmentObject(viewModel)
            
            Spacer()
        }
        .padding(32)
        .presentationBackgroundInteraction(.enabled)
        .presentationDetents([.fraction(0.4)])
    }
}

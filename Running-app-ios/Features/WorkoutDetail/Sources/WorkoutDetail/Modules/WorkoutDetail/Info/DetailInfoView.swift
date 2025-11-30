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
            VStack(alignment: .leading, spacing: 6) {
                SectionTitleView(title: viewModel.session.name)
                
                if let date = viewModel.session.timestamp?.formatted() {
                    Text(date)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.bottom, 8)
            
            WorkoutSummaryView(
                paceInSeconds: viewModel.session.paceInSeconds,
                distance: viewModel.session.distanceInKm,
                time: viewModel.session.totalTime
            )
            .padding(.horizontal, 8)
            
            PaceView()
                .environmentObject(viewModel)
            
            ElevationView()
                .environmentObject(viewModel)
            
            Spacer()
        }
        .padding(
            EdgeInsets(
                top: 32,
                leading: 32,
                bottom: 8,
                trailing: 32
            )
        )
        .presentationBackgroundInteraction(.enabled)
        .presentationDetents([.fraction(0.8)])
    }
}

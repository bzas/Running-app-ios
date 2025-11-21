//
//  WorkoutCellView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import SwiftUI
import Common

struct WorkoutCellView: View {
    
    @EnvironmentObject var viewModel: WorkoutCellViewModel

    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text(viewModel.session.name)
                        .font(.title2)
                    Spacer()
                    Text(viewModel.session.timestamp?.formatted() ?? "")
                        .font(.caption)
                        .opacity(0.75)
                }
                
                WorkoutSummaryView(session: viewModel.session)
            }
            .padding(.horizontal, 8)

            WorkoutMap(sessionRoute: viewModel.sessionRoute)
                .frame(height: 250)
                .clipShape(
                    RoundedRectangle(
                        cornerSize: CGSize(
                            width: 10,
                            height: 10
                        )
                    )
                )
        }
        .padding(12)
        .padding(.top, 8)
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(
            RoundedRectangle(
                cornerSize: CGSize(
                    width: 15,
                    height: 15
                )
            )
        )
        .padding(.horizontal, 16)
        .scrollTransition(.animated.threshold(.visible(0.2))) { content, phase in
            content
                .opacity(phase.isIdentity ? 1 : 0.8)
                .scaleEffect(phase.isIdentity ? 1 : 0.9)
                .blur(radius: phase.isIdentity ? 0 : 5)
        }
    }
}

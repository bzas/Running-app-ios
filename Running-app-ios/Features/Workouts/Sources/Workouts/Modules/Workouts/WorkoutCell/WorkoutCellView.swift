//
//  WorkoutCellView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import SwiftUI
import Common
import Domain

struct WorkoutCellView: View {
    
    let session: WorkoutSession
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text(session.name)
                        .font(.title2)
                    Spacer()
                    Text(session.timestamp?.formatted() ?? "")
                        .font(.caption)
                        .opacity(0.75)
                }
                
                WorkoutSummaryView(
                    paceInSeconds: session.paceInSeconds,
                    distance: session.distanceInKm,
                    time: session.totalTime
                )
            }
            .padding(.horizontal, 8)
            
            WorkoutMap(sessionRoute: session.locationPoints)
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
        .contentShape(Rectangle())
    }
}

//
//  WorkoutRowView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 15/11/25.
//

import SwiftUI
import Domain
import Common

struct WorkoutRowView: View {
    
    @Namespace var nameSpace

    let session: WorkoutSession
    let onTap: (WorkoutSession) -> Void

    var body: some View {
        Button {
            onTap(session)
        } label: {
            WorkoutCellView()
                .environmentObject(WorkoutCellViewModel(session: session))
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .matchedTransitionSource(
            id: TransitionManager.detailTransitionId(for: session.id),
            in: nameSpace
        )
    }
}

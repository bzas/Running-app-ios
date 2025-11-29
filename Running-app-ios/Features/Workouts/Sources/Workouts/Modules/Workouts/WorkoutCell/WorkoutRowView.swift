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
    
    let session: WorkoutSession
    let nameSpace: Namespace.ID
    let onTap: (WorkoutSession) -> Void

    var body: some View {
        Button {
            onTap(session)
        } label: {
            WorkoutCellView(session: session)
        }
        .buttonStyle(.plain)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
        .matchedTransitionSource(
            id: TransitionManager.detailTransitionId(for: session.id),
            in: nameSpace
        )
    }
}

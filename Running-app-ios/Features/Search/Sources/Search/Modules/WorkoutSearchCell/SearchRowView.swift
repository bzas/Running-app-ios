//
//  SearchRowView.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Domain
import Common
import Localization

struct SearchRowView: View {
    
    let session: WorkoutSession
    var nameSpace: Namespace.ID
    let onTap: (WorkoutSession) -> Void
    
    var body: some View {
        Button {
            onTap(session)
        } label: {
            SearchCell(session: session)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(
            String(
                format: Localizables.Accessibility.workoutRow,
                session.name,
                DataFormatter.distance(session.distanceInKm),
                DataFormatter.time(session.totalTime)
            )
        )
        .accessibilityHint(Localizables.Accessibility.openWorkout)
        .matchedTransitionSource(
            id: TransitionManager.detailTransitionId(for: session.id),
            in: nameSpace
        )
    }
}

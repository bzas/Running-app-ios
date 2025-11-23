//
//  SearchRowView.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Domain
import Common

struct SearchRowView: View {
    
    @State var session: WorkoutSession
    var nameSpace: Namespace.ID
    let onTap: (WorkoutSession) -> Void
    
    var body: some View {
        Button {
            onTap(session)
        } label: {
            SearchCell(session: session)
        }
        .buttonStyle(.plain)
        .matchedTransitionSource(
            id: TransitionManager.detailTransitionId(for: session.id),
            in: nameSpace
        )
    }
}

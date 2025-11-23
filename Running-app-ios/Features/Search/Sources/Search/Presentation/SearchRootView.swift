//
//  SearchRootView.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI
import WorkoutDetail

struct SearchRootView: View {
    
    @ObservedObject var coordinator: SearchCoordinator
    @Namespace var nameSpace
    
    var body: some View {
        NavigationStack {
            SearchView(
                viewModel: coordinator.assembly.makeSearchViewModel(),
                nameSpace: nameSpace,
                onOpenSession: { coordinator.open($0) }
            )
            .fullScreenCover(item: $coordinator.selectedSession) { session in
                coordinator.workoutDetailCoordinator.rootView(
                    session: session,
                    nameSpace: nameSpace,
                    onDismiss: coordinator.dismiss
                )
            }
        }
    }
}

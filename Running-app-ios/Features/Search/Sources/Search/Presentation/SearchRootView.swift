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
    @StateObject var viewModel: SearchViewModel
    
    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
        _viewModel = StateObject(
            wrappedValue: coordinator.assembly.makeSearchViewModel()
        )
    }
    
    var body: some View {
        NavigationStack {
            SearchView(
                viewModel: viewModel,
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
            .alert(
                viewModel.errorTitle ?? "Unknown error",
                isPresented: $viewModel.shouldShowErrorAlert
            ) {
                Button("OK") { }
            }
        }
    }
}

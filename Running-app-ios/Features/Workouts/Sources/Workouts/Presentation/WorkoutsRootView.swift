//
//  WorkoutsRootView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI

public struct WorkoutsRootView: View {
    
    @ObservedObject var coordinator: WorkoutsCoordinator
    
    public var body: some View {
        NavigationStack {
            WorkoutsView(
                viewModel: coordinator.assembly.makeWorkoutsViewModel()
            ) { session in
                coordinator.open(session)
            }
            .fullScreenCover(item: $coordinator.selectedSession) { session in
                WorkoutDetailView(
                    viewModel: coordinator.assembly.makeWorkoutDetailViewModel(for: session),
                    onDismiss: { coordinator.dismiss() }
                )
            }
        }
    }
}

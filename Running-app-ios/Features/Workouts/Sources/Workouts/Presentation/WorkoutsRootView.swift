//
//  WorkoutsRootView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI
import WorkoutDetail

public struct WorkoutsRootView: View {
    
    @ObservedObject var coordinator: WorkoutsCoordinator
    @StateObject private var viewModel: WorkoutsViewModel
    
    public init(coordinator: WorkoutsCoordinator) {
        self.coordinator = coordinator
        _viewModel = StateObject(
            wrappedValue: coordinator.assembly.makeWorkoutsViewModel()
        )
    }
    
    public var body: some View {
        NavigationStack {
            WorkoutsView(
                viewModel: viewModel,
                onOpenSession: { coordinator.open($0) },
                onOpenFilePicker: { coordinator.openFilePicker() }
            )
            .fullScreenCover(item: $coordinator.selectedSession) { session in
                WorkoutDetailAssembly.makeWorkoutDetailView(
                    for: session,
                    onDismiss: { coordinator.dismiss() }
                )
            }
            .fileImporter(
                isPresented: $coordinator.isPresentingFilePicker,
                allowedContentTypes: [.data]
            ) { result in
                switch result {
                case .success(let file):
                    viewModel.importFile(from: file)
                case .failure:
                    break
                }
            }
        }
    }
}

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
    @Namespace var nameSpace
    
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
                nameSpace: nameSpace,
                onOpenSession: { coordinator.open($0) },
                onOpenFilePicker: { coordinator.openFilePicker() }
            )
            .fullScreenCover(item: $coordinator.selectedSession) { session in
                coordinator.workoutDetailCoordinator.rootView(
                    session: session,
                    nameSpace: nameSpace,
                    onDismiss: coordinator.dismiss
                )
            }
            .onAppear {
                viewModel.requestHealthKitAccess()
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
            .alert(
                viewModel.errorTitle ?? "Unknown error",
                isPresented: $viewModel.shouldShowErrorAlert
            ) {
                Button("OK") { }
            }
        }
    }
}

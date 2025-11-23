//
//  WorkoutsCoordinator.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI
import Domain
import WorkoutDetail

@MainActor
public final class WorkoutsCoordinator: ObservableObject {
    
    let assembly: WorkoutsAssemblyProtocol & WorkoutDetailAssemblyProtocol
    let workoutDetailCoordinator: WorkoutDetailCoordinator

    @Published var selectedSession: WorkoutSession? = nil
    @Published var isPresentingFilePicker = false
    
    public init(assembly: WorkoutsAssemblyProtocol & WorkoutDetailAssemblyProtocol) {
        self.assembly = assembly
        self.workoutDetailCoordinator = WorkoutDetailCoordinator(assembly: assembly)
    }
    
    @ViewBuilder
    public func rootView() -> some View {
        WorkoutsRootView(coordinator: self)
    }
}

// MARK: - Module methods

extension WorkoutsCoordinator {
    
    func open(_ session: WorkoutSession) {
        selectedSession = session
    }
    
    func openFilePicker() {
        isPresentingFilePicker.toggle()
    }

    func dismiss() {
        selectedSession = nil
    }
}

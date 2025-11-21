//
//  WorkoutsCoordinator.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI
import Domain

@MainActor
public final class WorkoutsCoordinator: ObservableObject {
    
    let assembly: WorkoutsAssemblyProtocol
    
    @Published var selectedSession: WorkoutSession? = nil
    
    public init(assembly: WorkoutsAssemblyProtocol) {
        self.assembly = assembly
    }
    
    @ViewBuilder
    public func rootView() -> some View {
        WorkoutsRootView(coordinator: self)
    }
    
    public func open(_ session: WorkoutSession) {
        selectedSession = session
    }

    public func dismiss() {
        selectedSession = nil
    }
}

// MARK: - Aux methods

extension WorkoutsCoordinator {
    
    static func detailInfoTransitionId(for session: WorkoutSession) -> String {
         "detailInfoTransition-\(session.id.uuidString)"
     }
    
    static func galleryTransitionId(for session: WorkoutSession) -> String {
         "galleryTransition-\(session.id.uuidString)"
     }
    
    static func detailTransitionId(for session: WorkoutSession) -> String {
         "detailTransition-\(session.id.uuidString)"
     }
}

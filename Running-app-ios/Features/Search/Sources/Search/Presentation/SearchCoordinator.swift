//
//  SearchCoordinator.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import Foundation
import SwiftUI
import Domain
import WorkoutDetail

@MainActor
public final class SearchCoordinator: ObservableObject {
 
    let assembly: SearchAssemblyProtocol & WorkoutDetailAssemblyProtocol
    let workoutDetailCoordinator: WorkoutDetailCoordinator
    
    @Published var selectedSession: WorkoutSession? = nil

    public init(assembly: SearchAssemblyProtocol & WorkoutDetailAssemblyProtocol) {
        self.assembly = assembly
        self.workoutDetailCoordinator = WorkoutDetailCoordinator(assembly: assembly)
    }
    
    @ViewBuilder
    public func rootView() -> some View {
        SearchRootView(coordinator: self)
    }
}

// MARK: - Module methods

extension SearchCoordinator {
    
    func open(_ session: WorkoutSession) {
        selectedSession = session
    }

    func dismiss() {
        selectedSession = nil
    }
}

//
//  SearchCoordinator.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import Foundation
import SwiftUI
import Domain

@MainActor
public final class SearchCoordinator: ObservableObject {
 
    let assembly: SearchAssemblyProtocol
    
    @Published var selectedSession: WorkoutSession? = nil

    public init(assembly: SearchAssemblyProtocol) {
        self.assembly = assembly
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

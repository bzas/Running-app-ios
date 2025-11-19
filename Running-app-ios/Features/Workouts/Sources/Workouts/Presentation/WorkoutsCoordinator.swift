//
//  WorkoutsCoordinator.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI

@MainActor
public final class WorkoutsCoordinator {
    
    let assembly: WorkoutsAssemblyProtocol
    
    public init(assembly: WorkoutsAssemblyProtocol) {
        self.assembly = assembly
    }
    
    @ViewBuilder
    public func rootView() -> some View {
        WorkoutsView()
            .environmentObject(assembly.makeWorkoutsViewModel())
    }
}

//
//  WorkoutDetailCoordinator.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Domain

@MainActor
public final class WorkoutDetailCoordinator: ObservableObject {
    
    let assembly: WorkoutDetailAssemblyProtocol
    
    public init(assembly: WorkoutDetailAssemblyProtocol) {
        self.assembly = assembly
    }
    
    @ViewBuilder
    public func rootView(
        session: WorkoutSession,
        nameSpace: Namespace.ID,
        onDismiss: @escaping () -> Void
    ) -> some View {
        WorkoutDetailRootView(
            coordinator: self,
            session: session,
            nameSpace: nameSpace,
            onDismiss: onDismiss
        )
    }
}

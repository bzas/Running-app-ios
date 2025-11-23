//
//  WorkoutDetailAssemblyProtocol.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 21/11/25.
//

import Domain
import SwiftUI

@MainActor
public struct WorkoutDetailAssembly {
    
    public static func makeWorkoutDetailView(
        for session: WorkoutSession,
        nameSpace: Namespace.ID,
        onDismiss: @escaping () -> Void
    ) -> WorkoutDetailView {
        WorkoutDetailView(
            viewModel: WorkoutDetailViewModel(session: session),
            nameSpace: nameSpace,
            onDismiss: onDismiss
        )
    }
}

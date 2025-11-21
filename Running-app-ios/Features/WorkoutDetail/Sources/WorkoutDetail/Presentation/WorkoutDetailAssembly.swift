//
//  WorkoutDetailAssemblyProtocol.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 21/11/25.
//

import Domain

@MainActor
public struct WorkoutDetailAssembly {
    
    public static func makeWorkoutDetailView(
        for session: WorkoutSession,
        onDismiss: @escaping () -> Void
    ) -> WorkoutDetailView {
        WorkoutDetailView(
            viewModel: WorkoutDetailViewModel(session: session),
            onDismiss: onDismiss
        )
    }
}

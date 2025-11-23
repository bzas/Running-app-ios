//
//  WorkoutDetailAssemblyProtocol.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 21/11/25.
//

import Domain
import Application

public protocol WorkoutDetailAssemblyProtocol {
    
    func makeWorkoutDetailViewModel(
        for session: WorkoutSession,
        onDismiss: @escaping () -> Void
    ) -> WorkoutDetailViewModel
}

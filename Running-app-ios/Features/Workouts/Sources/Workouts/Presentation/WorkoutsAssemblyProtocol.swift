//
//  WorkoutsAssemblyProtocol.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain

public protocol WorkoutsAssemblyProtocol {
    
    func makeWorkoutsViewModel() -> WorkoutsViewModel
    func makeWorkoutDetailViewModel(for session: WorkoutSession) -> WorkoutDetailViewModel
}

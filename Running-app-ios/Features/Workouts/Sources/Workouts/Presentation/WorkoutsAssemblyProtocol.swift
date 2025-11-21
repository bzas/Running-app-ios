//
//  WorkoutsAssemblyProtocol.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain
import WorkoutDetail

public protocol WorkoutsAssemblyProtocol {
    
    func makeWorkoutsViewModel() -> WorkoutsViewModel
}

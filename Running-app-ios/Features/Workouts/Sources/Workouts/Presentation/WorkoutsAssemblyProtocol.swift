//
//  WorkoutsAssemblyProtocol.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain
import WorkoutDetail
import Foundation

public protocol WorkoutsAssemblyProtocol {
    
    func makeWorkoutsViewModel() -> WorkoutsViewModel
    func makeAppleHealthWorkoutsViewModel(
        delegate: AppleHealthImportDelegate?,
        alreadyImportedSessions: [UUID]
    ) -> AppleHealthWorkoutsViewModel
}

//
//  File.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation
import Domain

@MainActor
final class WorkoutCellViewModel: ObservableObject {
    @Published var session: WorkoutSession
    
    init(session: WorkoutSession) {
        self.session = session
    }
}

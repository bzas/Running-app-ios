//
//  WorkoutsViewModel.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import Foundation
import Domain
import Application

@MainActor
public final class WorkoutsViewModel: ObservableObject {
    
    @Published var sessions: [WorkoutSession] = []
    private let useCase: GarminUseCase
            
    public init(useCase: GarminUseCase) {
        self.useCase = useCase
    }
    
    func importFile(from file: URL) {
        Task {
            if let session = await useCase.fetch(from: file) {
                sessions.append(session)
            }
        }
    }
}

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
    
    func loadTestActivity() {
        sessions.removeAll()
        
        Task {
            guard let url = Bundle.module.url(forResource: "SampleActivity", withExtension: "fit"),
                  let data = try? Data(contentsOf: url) else {
                return
            }
            
            if let session = await useCase.fetch(from: data) {
                sessions.append(session)
            }
            
            if let session = await useCase.fetch(from: data) {
                sessions.append(session)
            }
            
            if let session = await useCase.fetch(from: data) {
                sessions.append(session)
            }
        }
    }
}

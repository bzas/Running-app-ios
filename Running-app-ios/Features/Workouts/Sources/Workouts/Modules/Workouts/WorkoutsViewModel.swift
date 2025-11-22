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
    private let useCase: WorkoutsUseCase
            
    public init(useCase: WorkoutsUseCase) {
        self.useCase = useCase
        
        Task {
            await fetchAll()
        }
    }
    
    func importFile(from file: URL) {
        Task {
            do {
                try await useCase.importSession(from: file)
                await fetchAll()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAll() async {
        do {
            sessions = try await useCase.fetchAllSessions()
        } catch {
            print(error.localizedDescription)
        }
    }
}

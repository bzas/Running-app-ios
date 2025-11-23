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
    @Published var isLoading = true
    
    // MARK: - Use cases
    
    private let garminUseCase: GarminImportUseCase
    private let workoutsUseCase: WorkoutsUseCase

    public init(
        garminUseCase: GarminImportUseCase,
        workoutsUseCase: WorkoutsUseCase
    ) {
        self.garminUseCase = garminUseCase
        self.workoutsUseCase = workoutsUseCase
        
        Task {
            await fetchAll()
        }
    }
    
    func importFile(from file: URL) {
        isLoading = true
        
        Task {
            do {
                try await garminUseCase.importSession(from: file)
                await fetchAll()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAll() async {
        do {
            sessions = try await workoutsUseCase.fetchAllSessions()
            isLoading = false
        } catch {
            print(error.localizedDescription)
        }
    }
}

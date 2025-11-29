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
    private let sessionImportUseCase: SessionImportUseCase
    private let workoutDeletionUseCase: WorkoutDeletionUseCase

    public init(
        garminUseCase: GarminImportUseCase,
        sessionImportUseCase: SessionImportUseCase,
        workoutDeletionUseCase: WorkoutDeletionUseCase
    ) {
        self.garminUseCase = garminUseCase
        self.sessionImportUseCase = sessionImportUseCase
        self.workoutDeletionUseCase = workoutDeletionUseCase
        
        fetchAll()
    }
    
    func importFile(from file: URL) {
        isLoading = true
        
        Task {
            do {
                try await garminUseCase.importSession(from: file)
                fetchAll()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchAll() {
        Task {
            do {
                sessions = try await sessionImportUseCase.fetchAllSessions()
                isLoading = false
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteSessions(at offsets: IndexSet) {
        Task {
            do {
                for offset in offsets {
                    try await workoutDeletionUseCase.delete(sessions[offset])
                }
                fetchAll()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

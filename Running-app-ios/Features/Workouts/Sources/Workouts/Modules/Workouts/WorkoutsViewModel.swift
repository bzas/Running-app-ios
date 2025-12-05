//
//  WorkoutsViewModel.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import Foundation
import Domain
import Application
import GarminKit
import Localization

@MainActor
public final class WorkoutsViewModel: ObservableObject {
    
    @Published var sessions: [WorkoutSession] = []
    @Published var isLoading = true
    
    // MARK: - Error handling
    
    @Published var shouldShowErrorAlert = false
    @Published var errorTitle: String?
    
    // MARK: - Use cases
    
    private let garminUseCase: GarminImportUseCaseProtocol
    private let sessionImportUseCase: SessionImportUseCaseProtocol
    private let workoutDeletionUseCase: WorkoutDeletionUseCaseProtocol

    public init(
        garminUseCase: GarminImportUseCaseProtocol,
        sessionImportUseCase: SessionImportUseCaseProtocol,
        workoutDeletionUseCase: WorkoutDeletionUseCaseProtocol
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
                showError(error)
            }
        }
    }
    
    func fetchAll() {
        Task {
            do {
                sessions = try await sessionImportUseCase.fetchAllSessions()
                isLoading = false
            } catch {
                showError(error)
            }
        }
    }
    
    func deleteSessions(at offsets: IndexSet) {
        Task {
            do {
                for offset in offsets {
                    try await workoutDeletionUseCase.delete(sessions[offset])
                    sessions.remove(at: offset)
                }
            } catch {
                showError(error)
            }
        }
    }
    
    func showError(_ error: Error) {
        errorTitle = error.localizedDescription
        shouldShowErrorAlert.toggle()
    }
}

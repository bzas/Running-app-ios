//
//  AppleHealthWorkoutsViewModel.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import Foundation
import Application
import Domain
import Common

@MainActor
public final class AppleHealthWorkoutsViewModel: ObservableObject {
        
    @Published var sessions: [WorkoutSession] = []
    @Published var isLoading = true
    @Published var alreadyImportedSessions: [UUID] = []
    
    weak var delegate: AppleHealthImportDelegate?
    
    // MARK: - Use Cases

    let getHealthWorkoutsUseCase: GetHealthWorkoutsUseCaseProtocol
    let importHealthWorkoutUseCase: ImportHealthWorkoutUseCaseProtocol
    
    public init(
        getHealthWorkoutsUseCase: GetHealthWorkoutsUseCaseProtocol,
        importHealthWorkoutUseCase: ImportHealthWorkoutUseCaseProtocol,
        alreadyImportedSessions: [UUID],
        delegate: AppleHealthImportDelegate?
    ) {
        self.getHealthWorkoutsUseCase = getHealthWorkoutsUseCase
        self.importHealthWorkoutUseCase = importHealthWorkoutUseCase
        self.alreadyImportedSessions = alreadyImportedSessions
        self.delegate = delegate
    }
    
    func fetchHealthWorkouts() {
        isLoading = true
        
        Task {
            do {
                AppLogger.appleHealth.info("Loading Health workouts.")
                sessions = try await getHealthWorkoutsUseCase.fetchWorkouts()
                isLoading = false
            } catch {
                isLoading = false
                AppLogger.appleHealth.error("Health workouts error: \(error.localizedDescription, privacy: .public)")
            }
        }
    }
    
    func fetchComplete(session: WorkoutSession) {
        Task {
            do {
                AppLogger.appleHealth.info("Fetching full Health workout.")
                try await importHealthWorkoutUseCase.fetchCompleteWorkout(lightWeightSession: session)
                delegate?.didImportNewWorkout()
            } catch {
                AppLogger.appleHealth.error("Health workout import error: \(error.localizedDescription, privacy: .public)")
            }
        }
    }
}

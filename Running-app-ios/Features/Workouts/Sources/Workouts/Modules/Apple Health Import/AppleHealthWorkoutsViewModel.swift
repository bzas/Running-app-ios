//
//  AppleHealthWorkoutsViewModel.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import Foundation
import Application
import Domain

@MainActor
public final class AppleHealthWorkoutsViewModel: ObservableObject {
        
    @Published var sessions: [WorkoutSession] = []
    @Published var isLoading = true
    
    weak var delegate: AppleHealthImportDelegate?
    
    // MARK: - Use Cases

    let getHealthWorkoutsUseCase: GetHealthWorkoutsUseCaseProtocol
    let importHealthWorkoutUseCase: ImportHealthWorkoutUseCaseProtocol
    
    public init(
        getHealthWorkoutsUseCase: GetHealthWorkoutsUseCaseProtocol,
        importHealthWorkoutUseCase: ImportHealthWorkoutUseCaseProtocol,
        delegate: AppleHealthImportDelegate?
    ) {
        self.getHealthWorkoutsUseCase = getHealthWorkoutsUseCase
        self.importHealthWorkoutUseCase = importHealthWorkoutUseCase
        self.delegate = delegate
    }
    
    func fetchHealthWorkouts() {
        isLoading = true
        
        Task {
            do {
                sessions = try await getHealthWorkoutsUseCase.fetchWorkouts()
                isLoading = false
            } catch {
                isLoading = false
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchComplete(session: WorkoutSession) {
        Task {
            do {
                try await importHealthWorkoutUseCase.fetchCompleteWorkout(lightWeightSession: session)
                delegate?.didImportNewWorkout()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

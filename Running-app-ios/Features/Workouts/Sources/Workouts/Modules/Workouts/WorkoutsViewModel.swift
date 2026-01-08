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
    @Published var isLoadingPage = false
    
    // MARK: - Error handling
    
    @Published var shouldShowErrorAlert = false
    @Published var errorTitle: String?
    
    // MARK: - Use cases
    
    private let garminUseCase: GarminImportUseCaseProtocol
    private let sessionImportUseCase: SessionImportUseCaseProtocol
    private let workoutDeletionUseCase: WorkoutDeletionUseCaseProtocol
    private let requestHealthKitAccessUseCase: RequestHealthAccessUseCaseProtocol
    private let pageSize = 20
    private var currentPage = 0
    private var canLoadMore = true

    public init(
        garminUseCase: GarminImportUseCaseProtocol,
        sessionImportUseCase: SessionImportUseCaseProtocol,
        workoutDeletionUseCase: WorkoutDeletionUseCaseProtocol,
        requestHealthKitAccessUseCase: RequestHealthAccessUseCaseProtocol
    ) {
        self.garminUseCase = garminUseCase
        self.sessionImportUseCase = sessionImportUseCase
        self.workoutDeletionUseCase = workoutDeletionUseCase
        self.requestHealthKitAccessUseCase = requestHealthKitAccessUseCase
        
        fetchAll()
    }
    
    func importFile(from file: URL) {
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
            await loadPage(reset: true)
        }
    }

    func loadMoreIfNeeded(currentItem: WorkoutSession) {
        guard currentItem.id == sessions.last?.id else { return }
        Task {
            await loadPage(reset: false)
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
    
    func requestHealthKitAccess() {
        Task {
            try? await requestHealthKitAccessUseCase.requestUserPermission()
        }
    }
}

// MARK: - Pagination

private extension WorkoutsViewModel {

    func loadPage(reset: Bool) async {
        if reset {
            isLoading = true
            isLoadingPage = false
            currentPage = 0
            canLoadMore = true
            sessions = []
        } else {
            guard !isLoadingPage, canLoadMore else { return }
            isLoadingPage = true
        }

        let pageToLoad = currentPage

        do {
            let newSessions = try await sessionImportUseCase.fetchAllSessions(
                lightWeight: false,
                page: pageToLoad,
                pageSize: pageSize
            )

            if reset {
                sessions = newSessions
                isLoading = false
            } else {
                sessions.append(contentsOf: newSessions)
            }

            currentPage = pageToLoad + 1
            canLoadMore = newSessions.count == pageSize
        } catch {
            if reset {
                isLoading = false
            }
            showError(error)
        }

        if !reset {
            isLoadingPage = false
        }
    }
}

// MARK: - AppleHealthImportDelegate conformance

extension WorkoutsViewModel: AppleHealthImportDelegate {
    
    public func didImportNewWorkout() {
        fetchAll()
    }
}

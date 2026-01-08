//
//  SearchViewModel.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import Foundation
import Domain
import Application
import Common

@MainActor
public final class SearchViewModel: ObservableObject {
    
    private var allSessions: [WorkoutSession] = []
    @Published var sessions: [WorkoutSession] = []
    @Published var searchText: String = ""
    @Published var isLoading = true
    
    // MARK: - Error handling
    
    @Published var shouldShowErrorAlert = false
    @Published var errorTitle: String?
    
    // MARK: - Use case
    
    private let sessionImportUseCase: SessionImportUseCaseProtocol
    
    public init(
        sessionImportUseCase: SessionImportUseCaseProtocol
    ) {
        self.sessionImportUseCase = sessionImportUseCase
    }
    
    func fetchAll() {
        isLoading = true
        allSessions = []
        Task { [weak self] in
            guard let self else { return }
            do {
                AppLogger.search.info("Loading sessions for search.")
                allSessions = try await sessionImportUseCase.fetchAllSessions(lightWeight: false)
                AppLogger.search.info("Loaded search sessions count=\(self.allSessions.count, privacy: .public).")
                self.sessions = self.allSessions
                isLoading = false
            } catch {
                showError(error)
            }
        }
    }
    
    func applyFilters() {
        guard !searchText.isEmpty else {
            sessions = allSessions
            return
        }
        
        sessions = allSessions.filter { session in
            session.name.contains(searchText)
        }
    }
    
    func showError(_ error: Error) {
        errorTitle = error.localizedDescription
        shouldShowErrorAlert.toggle()
        AppLogger.search.error("Search error: \(error.localizedDescription, privacy: .public)")
    }
}

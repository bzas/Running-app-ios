//
//  SearchViewModel.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import Foundation
import Domain
import Application

@MainActor
public final class SearchViewModel: ObservableObject {
    
    private var allSessions: [WorkoutSession] = []
    @Published var sessions: [WorkoutSession] = []
    @Published var searchText: String = ""
    @Published var isLoading = true
    
    // MARK: - Use case
    
    private let sessionImportUseCase: SessionImportUseCase
    
    public init(
        sessionImportUseCase: SessionImportUseCase
    ) {
        self.sessionImportUseCase = sessionImportUseCase
    }
    
    func fetchAll() {
        isLoading = true
        allSessions = []
        Task {
            do {
                allSessions = try await sessionImportUseCase.fetchAllSessions()
                sessions = allSessions
                isLoading = false
            } catch {
                print(error.localizedDescription)
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
}

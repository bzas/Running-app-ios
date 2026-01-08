//
//  Untitled.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import Foundation
import Domain
import Application
import Common

@MainActor
public final class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var photos: [SessionPhoto] = []
    @Published var userInfo: User?
    @Published var sessions: [WorkoutSession] = []
    @Published var sessionDaysAndKmsOfYear: [DayAndKms] = []
    
    // MARK: - Error handling
    
    @Published var shouldShowErrorAlert = false
    @Published var errorTitle: String?
    
    var totalKilometers: Double {
        lastYearSessions.map(\.distanceInKm).reduce(0, +)
    }
    
    var totalWorkouts: Int {
        lastYearSessions.count
    }
    
    private var lastYearSessions: [WorkoutSession] = []
    
    // MARK: - Presentation
    
    @Published var presentedPhoto: SessionPhoto?
    @Published var tappedDaySession: WorkoutSession?
    @Published var tappedDayIndex: Int?
    @Published var isShowingEditUser = false

    // MARK: - Use cases
    
    private let getGalleryUseCase: GetGalleryUseCaseProtocol
    private let updateGalleryUseCase: UpdateGalleryUseCaseProtocol
    private let getUserUseCase: GetUserUseCaseProtocol
    private let sessionImportUseCase: SessionImportUseCaseProtocol
    
    public init(
        getGalleryUseCase: GetGalleryUseCaseProtocol,
        updateGalleryUseCase: UpdateGalleryUseCaseProtocol,
        getUserUseCase: GetUserUseCaseProtocol,
        sessionImportUseCase: SessionImportUseCaseProtocol
    ) {
        self.getGalleryUseCase = getGalleryUseCase
        self.updateGalleryUseCase = updateGalleryUseCase
        self.getUserUseCase = getUserUseCase
        self.sessionImportUseCase = sessionImportUseCase
    }
    
    func deletePhoto(_ photo: SessionPhoto) {
        Task {
            do {
                photos.removeAll(where: { $0.id == photo.id })
                try await updateGalleryUseCase.deletePhoto(photo)
                presentedPhoto = nil
            } catch {
                showError(error)
            }
        }
    }
    
    func tapOnDay(index: Int) {
        guard let daySession = sessionDaysAndKmsOfYear.first(where: { $0.day == index + 1 }) else {
            resetDayTapped()
            return
        }
        
        tappedDayIndex = index
        tappedDaySession = sessions.first {
            $0.id == daySession.id
        }
    }
    
    func resetDayTapped() {
        tappedDayIndex = nil
        tappedDaySession = nil
    }
}

// MARK: - Private methods

extension ProfileViewModel {
    
    func setup() {
        isShowingEditUser = false
        sessionDaysAndKmsOfYear = []
        sessions = []
        lastYearSessions = []
        photos = []

        AppLogger.profile.info("Profile setup started.")
        
        fetchSessions()
        fetchUserInfo()
        fetchGallery()
    }
    
    func fetchSessions() {
        Task { [weak self] in
            guard let self else { return }
            do {
                AppLogger.profile.info("Loading profile sessions.")
                sessions = try await sessionImportUseCase.fetchAllSessions(lightWeight: true)
                AppLogger.profile.info("Loaded profile sessions count=\(self.sessions.count, privacy: .public).")
                
                let calendar = Calendar.current
                let currentYear = calendar.component(.year, from: Date())
                lastYearSessions = sessions.filter { session in
                    guard let timestamp = session.timestamp else { return false }
                    return calendar.component(.year, from: timestamp) == currentYear
                }
                
                sessionDaysAndKmsOfYear = lastYearSessions.compactMap {
                    DayAndKms(session: $0)
                }
            } catch {
                showError(error)
            }
        }
    }
    
    func fetchUserInfo() {
        Task {
            do {
                AppLogger.profile.info("Loading user info.")
                userInfo = try await getUserUseCase.currentUser()
            } catch {
                showError(error)
            }
        }
    }
    
    func fetchGallery() {
        Task {
            do {
                AppLogger.profile.info("Loading gallery.")
                photos = try await getGalleryUseCase.getAllPhotos()
            } catch {
                showError(error)
            }
        }
    }
    
    func showError(_ error: Error) {
        errorTitle = error.localizedDescription
        shouldShowErrorAlert.toggle()
        AppLogger.profile.error("Profile error: \(error.localizedDescription, privacy: .public)")
    }
}

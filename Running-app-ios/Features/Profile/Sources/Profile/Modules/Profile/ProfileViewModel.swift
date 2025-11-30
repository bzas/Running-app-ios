//
//  Untitled.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import Foundation
import Domain
import Application

typealias DayAndKms = (day: Int, kms: Double)

@MainActor
public final class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var photos: [SessionPhoto] = []
    @Published var userInfo: User?
    @Published var sessions: [WorkoutSession] = []
    @Published var sessionDaysAndKmsOfYear: [DayAndKms] = []
    @Published var presentedPhoto: SessionPhoto?
    
    // MARK: - Use cases
    
    private let getGalleryUseCase: GetGalleryUseCase
    private let updateGalleryUseCase: UpdateGalleryUseCase
    private let getUserUseCase: GetUserUseCase
    private let sessionImportUseCase: SessionImportUseCase
    
    public init(
        getGalleryUseCase: GetGalleryUseCase,
        updateGalleryUseCase: UpdateGalleryUseCase,
        getUserUseCase: GetUserUseCase,
        sessionImportUseCase: SessionImportUseCase
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
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Private methods

extension ProfileViewModel {
    
    func setup() {
        sessions = []
        photos = []
        
        Task {
            await fetchSessions()
            await fetchUserInfo()
            await fetchGallery()
        }
    }
    
    func fetchSessions() async {
        do {
            sessions = try await sessionImportUseCase.fetchAllSessions()
            sessionDaysAndKmsOfYear = sessions
                .map {
                    DayAndKms(
                        day: $0.timestamp?.dayOfYear ?? 0,
                        kms: $0.distanceInKm
                    )
                }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUserInfo() async {
        do {
            userInfo = try await getUserUseCase.currentUser()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchGallery() async {
        do {
            photos = try await getGalleryUseCase.getAllPhotos()
        } catch {
            print(error.localizedDescription)
        }
    }
}

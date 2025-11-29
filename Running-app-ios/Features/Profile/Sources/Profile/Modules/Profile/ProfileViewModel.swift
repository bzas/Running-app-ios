//
//  Untitled.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import Foundation
import Domain
import Application

@MainActor
public final class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var photos: [SessionPhoto] = []
    @Published var presentedPhoto: SessionPhoto?
    
    // MARK: - Use cases
    
    private let getGalleryUseCase: GetGalleryUseCase
    private let updateGalleryUseCase: UpdateGalleryUseCase
    private let getUserUseCase: GetUserUseCase
    
    public init(
        getGalleryUseCase: GetGalleryUseCase,
        updateGalleryUseCase: UpdateGalleryUseCase,
        getUserUseCase: GetUserUseCase
    ) {
        self.getGalleryUseCase = getGalleryUseCase
        self.updateGalleryUseCase = updateGalleryUseCase
        self.getUserUseCase = getUserUseCase
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
        Task {
            await fetchGallery()
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

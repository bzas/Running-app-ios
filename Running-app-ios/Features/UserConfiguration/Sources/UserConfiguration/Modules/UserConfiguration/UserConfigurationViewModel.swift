//
//  UserConfigurationViewModel.swift
//  UserConfiguration
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Foundation
import Application
import Domain
import Common

@MainActor
public final class UserConfigurationViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var name = ""
    @Published var age = ""
    @Published var maxHeartRate = ""
    
    // MARK: - Error handling
    
    @Published var shouldShowErrorAlert = false
    @Published var errorTitle: String?
    
    var savedUser: User?
    private let completion: (() -> Void)?
    
    // MARK: Use cases
 
    private let createUserUseCase: CreateUserUseCaseProtocol
    private let editUserUseCase: EditUserUseCaseProtocol

    public init(
        createUserUseCase: CreateUserUseCaseProtocol,
        editUserUseCase: EditUserUseCaseProtocol,
        savedUser: User?,
        completion: (() -> Void)?
    ) {
        self.createUserUseCase = createUserUseCase
        self.editUserUseCase = editUserUseCase
        self.savedUser = savedUser
        self.completion = completion
        
        if let savedUser {
            name = savedUser.name
            age = "\(savedUser.age)"
            maxHeartRate = "\(savedUser.maxHeartRate)"
        }
    }
    
    func trySaveUserData() async -> Bool {
        guard let user = makeUserFromInput() else { return false }
        
        do {
            if savedUser != nil {
                AppLogger.userConfig.info("Updating user.")
                try await editUserUseCase.update(user)
            } else {
                AppLogger.userConfig.info("Creating user.")
                try await createUserUseCase.save(user)
            }
            completion?()
            return true
        } catch {
            showError(error)
            return false
        }
    }
}

// MARK: - Private methods

private extension UserConfigurationViewModel {
    
    func makeUserFromInput() -> User? {
        guard !name.isEmpty,
              !age.isEmpty,
              !maxHeartRate.isEmpty,
                let age = Int(age),
              let maxHeartRate = Int(maxHeartRate) else {
            return nil
        }
        
        if var savedUser {
            savedUser.name = name
            savedUser.age = age
            savedUser.maxHeartRate = maxHeartRate
            return savedUser
        } else {
            return User(
                name: name,
                age: age,
                maxHeartRate: maxHeartRate
            )
        }
    }
    
    func showError(_ error: Error) {
        errorTitle = error.localizedDescription
        shouldShowErrorAlert.toggle()
        AppLogger.userConfig.error("User configuration error: \(error.localizedDescription, privacy: .public)")
    }
}

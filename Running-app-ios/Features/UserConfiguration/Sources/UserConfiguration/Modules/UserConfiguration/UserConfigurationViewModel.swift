//
//  UserConfigurationViewModel.swift
//  UserConfiguration
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Foundation
import Application
import Domain

@MainActor
public final class UserConfigurationViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var name = ""
    @Published var age = ""
    @Published var maxHeartRate = ""
    
    var savedUser: User?
    private let completion: (() -> Void)?
    
    // MARK: Use cases
 
    private let createUserUseCase: CreateUserUseCase
    private let editUserUseCase: EditUserUseCase

    public init(
        createUserUseCase: CreateUserUseCase,
        editUserUseCase: EditUserUseCase,
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
                try await editUserUseCase.update(user)
            } else {
                try await createUserUseCase.save(user)
            }
            completion?()
            return true
        } catch {
            print(error.localizedDescription)
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
}

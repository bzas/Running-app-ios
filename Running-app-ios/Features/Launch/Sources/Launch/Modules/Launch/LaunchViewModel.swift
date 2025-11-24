//
//  LaunchViewModel.swift
//  Launch
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Foundation
import Application
import Domain

@MainActor
public final class LaunchViewModel: ObservableObject {
    
    @Published var name = ""
    @Published var age = ""
    @Published var maxHeartRate = ""
    
    // MARK: Use cases
 
    private let createUserUseCase: CreateUserUseCase
            
    public init(createUserUseCase: CreateUserUseCase) {
        self.createUserUseCase = createUserUseCase
    }
    
    func trySaveUserData() async -> Bool {
        guard !name.isEmpty,
              !age.isEmpty,
              !maxHeartRate.isEmpty,
                let age = Int(age),
              let maxHeartRate = Int(maxHeartRate) else {
            return false
        }
        
        let user = User(
            name: name,
            age: age,
            maxHeartRate: maxHeartRate
        )
        
        do {
            try await createUserUseCase.save(user)
            return true
        } catch {
            return false
        }
    }
}

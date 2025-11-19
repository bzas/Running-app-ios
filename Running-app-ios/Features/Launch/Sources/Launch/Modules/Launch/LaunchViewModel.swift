//
//  LaunchViewModel.swift
//  Launch
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Foundation
import Application

@MainActor
public final class LaunchViewModel: ObservableObject {
 
    private let useCase: UserUseCase
            
    public init(useCase: UserUseCase) {
        self.useCase = useCase
    }
}

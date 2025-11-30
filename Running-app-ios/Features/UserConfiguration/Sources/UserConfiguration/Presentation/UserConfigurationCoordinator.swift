//
//  UserConfigurationCoordinator.swift
//  UserConfiguration
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI
import Domain

@MainActor
public final class UserConfigurationCoordinator: ObservableObject {
    
    let assembly: UserConfigurationAssemblyProtocol
    
    public init(assembly: UserConfigurationAssemblyProtocol) {
        self.assembly = assembly
    }
    
    @ViewBuilder
    public func rootView(
        savedUser: User? = nil,
        completion: (() -> Void)? = nil
    ) -> some View {
        UserConfigurationRootView(
            coordinator: self,
            savedUser: savedUser,
            completion: completion
        )
    }
}

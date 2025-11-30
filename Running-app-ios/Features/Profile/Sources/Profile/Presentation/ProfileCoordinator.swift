//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI
import UserConfiguration

@MainActor
public final class ProfileCoordinator: ObservableObject {
    
    let assembly: ProfileAssemblyProtocol & UserConfigurationAssemblyProtocol
    let userConfigurationCoordinator: UserConfigurationCoordinator
    
    public init(assembly: ProfileAssemblyProtocol & UserConfigurationAssemblyProtocol) {
        self.assembly = assembly
        self.userConfigurationCoordinator = UserConfigurationCoordinator(assembly: assembly)
    }
    
    @ViewBuilder
    public func rootView() -> some View {
        ProfileRootView(coordinator: self)
    }
}

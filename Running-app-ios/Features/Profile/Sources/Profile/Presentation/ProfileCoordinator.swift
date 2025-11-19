//
//  ProfileCoordinator.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI

@MainActor
public final class ProfileCoordinator {
    
    let assembly: ProfileAssemblyProtocol
    
    public init(assembly: ProfileAssemblyProtocol) {
        self.assembly = assembly
    }
    
    @ViewBuilder
    public func rootView() -> some View {
        ProfileView()
            .environmentObject(assembly.makeProfileViewModel())
    }
}

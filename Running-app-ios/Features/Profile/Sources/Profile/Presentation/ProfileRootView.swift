//
//  ProfileRootView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI

public struct ProfileRootView: View {
    
    @ObservedObject var coordinator: ProfileCoordinator
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
    }

    public var body: some View {
        ProfileView(
            viewModel: coordinator.assembly.makeProfileViewModel()
        )
    }
}

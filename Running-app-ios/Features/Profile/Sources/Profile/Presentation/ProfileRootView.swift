//
//  ProfileRootView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI

public struct ProfileRootView: View {
    
    @ObservedObject var coordinator: ProfileCoordinator

    public var body: some View {
        NavigationStack {
            ProfileView(
                viewModel: coordinator.assembly.makeProfileViewModel()
            )
        }
    }
}

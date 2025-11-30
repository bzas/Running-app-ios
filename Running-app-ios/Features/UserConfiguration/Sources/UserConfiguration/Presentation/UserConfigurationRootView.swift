//
//  UserConfigurationRootView.swift
//  UserConfiguration
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI
import Domain

struct UserConfigurationRootView: View {
    
    @ObservedObject var coordinator: UserConfigurationCoordinator
    let savedUser: User?
    let completion: (() -> Void)?

    var body: some View {
        NavigationStack {
            UserConfigurationView(
                viewModel: coordinator.assembly.makeUserConfigurationViewModel(
                    savedUser: savedUser,
                    completion: completion
                )
            )
        }
    }
}

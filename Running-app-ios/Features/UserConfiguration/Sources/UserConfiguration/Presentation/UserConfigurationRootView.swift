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
    @StateObject var viewModel: UserConfigurationViewModel
    
    init(
        coordinator: UserConfigurationCoordinator,
        savedUser: User?,
        completion: (() -> Void)?
    ) {
        self.coordinator = coordinator
        
        _viewModel = StateObject(
            wrappedValue: coordinator.assembly.makeUserConfigurationViewModel(
                savedUser: savedUser,
                completion: completion
            )
        )
    }

    var body: some View {
        NavigationStack {
            UserConfigurationView(viewModel: viewModel)
                .alert(
                    viewModel.errorTitle ?? "Unknown error",
                    isPresented: $viewModel.shouldShowErrorAlert
                ) {
                    Button("OK") { }
                }
        }
    }
}

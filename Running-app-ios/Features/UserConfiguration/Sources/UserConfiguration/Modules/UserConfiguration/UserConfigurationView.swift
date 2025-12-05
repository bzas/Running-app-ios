//
//  UserConfigurationView.swift
//  UserConfiguration
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI
import Localization

struct UserConfigurationView: View {
    
    @AppStorage("userDataNeeded") var userDataNeeded: Bool = true
    @StateObject var viewModel: UserConfigurationViewModel
    
    init(viewModel: UserConfigurationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        Form {
            Section {
                TextField(Localizables.UserConfiguration.name, text: $viewModel.name)
                
                TextField(Localizables.UserConfiguration.age, text: $viewModel.age)
                    .keyboardType(.numberPad)
                
                TextField(Localizables.UserConfiguration.maximumHeartRate, text: $viewModel.maxHeartRate)
                    .keyboardType(.numberPad)
            }
        }
        .navigationTitle(Localizables.UserConfiguration.aboutYou)
        .navigationBarTitleDisplayMode(.inline)
        .interactiveDismissDisabled(viewModel.savedUser == nil)
        .presentationDetents([.fraction(0.4)])
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        userDataNeeded = await !viewModel.trySaveUserData()
                    }
                } label: {
                    Text(Localizables.UserConfiguration.save)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
            }
        }
    }
}

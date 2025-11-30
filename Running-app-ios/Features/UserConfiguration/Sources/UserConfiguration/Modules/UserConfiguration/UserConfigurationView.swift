//
//  UserConfigurationView.swift
//  UserConfiguration
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI

struct UserConfigurationView: View {
    
    @AppStorage("userDataNeeded") var userDataNeeded: Bool = true
    @StateObject var viewModel: UserConfigurationViewModel
    
    init(viewModel: UserConfigurationViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.name)
                
                TextField("Age", text: $viewModel.age)
                    .keyboardType(.numberPad)
                
                TextField("Maximum heart rate", text: $viewModel.maxHeartRate)
                    .keyboardType(.numberPad)
            }
        }
        .navigationTitle("About you")
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
                    Text("Save")
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
            }
        }
    }
}

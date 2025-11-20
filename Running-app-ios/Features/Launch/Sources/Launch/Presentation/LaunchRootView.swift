//
//  LaunchRootView.swift
//  Launch
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI

struct LaunchRootView: View {
    
    @ObservedObject var coordinator: LaunchCoordinator
    
    var body: some View {
        NavigationStack {
            LaunchView(
                viewModel: coordinator.assembly.makeLaunchViewModel()
            )
        }
    }
}

//
//  LaunchRootView.swift
//  Launch
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI

struct LaunchRootView: View {
    
    @ObservedObject var coordinator: LaunchCoordinator
    
    init(coordinator: LaunchCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        LaunchView(
            viewModel: coordinator.assembly.makeLaunchViewModel()
        )
    }
}

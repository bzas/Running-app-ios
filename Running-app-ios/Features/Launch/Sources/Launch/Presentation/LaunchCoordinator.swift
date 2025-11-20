//
//  LaunchCoordinator.swift
//  Launch
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI

@MainActor
public final class LaunchCoordinator: ObservableObject {
    
    let assembly: LaunchAssemblyProtocol
    
    public init(assembly: LaunchAssemblyProtocol) {
        self.assembly = assembly
    }
    
    @ViewBuilder
    public func rootView() -> some View {
        LaunchRootView(coordinator: self)
    }
}

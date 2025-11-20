//
//  LaunchView.swift
//  Launch
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import SwiftUI

struct LaunchView: View {
    
    @StateObject var viewModel: LaunchViewModel
    
    init(viewModel: LaunchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    public var body: some View {
        Text("Test")
    }
}

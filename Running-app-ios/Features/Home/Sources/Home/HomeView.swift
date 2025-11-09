//
//  SwiftUIView.swift
//  Home
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import SwiftUI

public struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel

    public init() {
        _viewModel = StateObject(wrappedValue: HomeViewModel())
    }
    
    public var body: some View {
        Text("Home")
    }
}

#Preview {
    HomeView()
}

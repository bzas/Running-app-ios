//
//  SwiftUIView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel

    public init() {
        _viewModel = StateObject(wrappedValue: ProfileViewModel())
    }
    
    public var body: some View {
        Text("Profile")
    }
}

#Preview {
    ProfileView()
}

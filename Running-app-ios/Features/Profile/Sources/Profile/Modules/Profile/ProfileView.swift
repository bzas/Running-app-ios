//
//  SwiftUIView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import SwiftUI
import Localization

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel
    var nameSpace: Namespace.ID
    
    public var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ProfileHeaderView()
                ActivityGridView()
                ProfileHeartRateZonesView()
                ProfileGalleryView(nameSpace: nameSpace)
                Spacer()
            }
            .environmentObject(viewModel)
            .padding()
        }
        .scrollIndicators(.hidden)
        .navigationTitle(Localizables.Profile.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.setup()
        }
    }
}

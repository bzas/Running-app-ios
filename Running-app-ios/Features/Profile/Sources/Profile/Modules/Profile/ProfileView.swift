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
        VStack(alignment: .leading) {
            ProfileGalleryView(nameSpace: nameSpace)
                .environmentObject(viewModel)
            
            Spacer()
        }
        .padding()
        .navigationTitle(Localizables.Profile.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.setup()
        }
    }
}

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
                ActivitySummaryView()
                
                if !viewModel.photos.isEmpty {
                    ProfileGalleryView(nameSpace: nameSpace)
                }
                
                ProfileHeartRateZonesView()
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.isShowingEditUser.toggle()
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "square.and.pencil")
                            .font(.footnote)
                        Text("Edit")
                    }
                    .padding(.horizontal, 6)
                }
            }
        }
    }
}

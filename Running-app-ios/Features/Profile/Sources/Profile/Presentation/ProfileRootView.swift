//
//  ProfileRootView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI
import Common

public struct ProfileRootView: View {
    
    @ObservedObject var coordinator: ProfileCoordinator
    @StateObject private var viewModel: ProfileViewModel
    @Namespace var nameSpace
    
    init(coordinator: ProfileCoordinator) {
        self.coordinator = coordinator
        _viewModel = StateObject(
            wrappedValue: coordinator.assembly.makeProfileViewModel()
        )
    }

    public var body: some View {
        NavigationStack {
            ProfileView(nameSpace: nameSpace)
                .environmentObject(viewModel)
        }
        .fullScreenCover(item: $viewModel.presentedPhoto) { photoItem in
            PhotoDetailView(
                imageData: photoItem.data,
                nameSpace: nameSpace,
                onDeleteImage: {
                    viewModel.deletePhoto(photoItem)
                },
                onDismiss: {
                    viewModel.presentedPhoto = nil
                }
            )
            .navigationTransition(
                .zoom(
                    sourceID: TransitionManager.detailImageTransitionId(for: photoItem.id),
                    in: nameSpace
                )
            )
        }
    }
}

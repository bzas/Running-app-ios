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
        .overlayPreferenceValue(DayCellAnchorKey.self) { preferences in
            GeometryReader { proxy in
                if let tappedSession = viewModel.tappedDaySession,
                   let tappedIndex = viewModel.tappedDayIndex,
                   let anchor = preferences[tappedIndex] {
                    let frame = proxy[anchor]
                    
                    DayInfoView(
                        name: tappedSession.name,
                        date: DataFormatter.shortDate(tappedSession.timestamp),
                        distance: DataFormatter.distance(tappedSession.distanceInKm)
                    )
                    .onTapGesture {
                        viewModel.resetDayTapped()
                    }
                    .position(
                        x: frame.midX,
                        y: frame.minY - 28
                    )
                    .transition(.opacity)
                    .animation(.easeInOut, value: tappedIndex)
                }
            }
        }
    }
}

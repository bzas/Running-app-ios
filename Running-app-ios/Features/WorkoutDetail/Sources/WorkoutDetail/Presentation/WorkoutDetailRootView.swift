//
//  WorkoutDetailRootView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Domain
import Common

struct WorkoutDetailRootView: View {
    
    @ObservedObject var coordinator: WorkoutDetailCoordinator
    @StateObject private var viewModel: WorkoutDetailViewModel
    
    var session: WorkoutSession
    var nameSpace: Namespace.ID
    var onDismiss: () -> Void
    
    public init(
        coordinator: WorkoutDetailCoordinator,
        session: WorkoutSession,
        nameSpace: Namespace.ID,
        onDismiss: @escaping () -> Void
    ) {
        self.coordinator = coordinator
        self.nameSpace = nameSpace
        self.onDismiss = onDismiss
        self.session = session
        
        _viewModel = StateObject(
            wrappedValue: coordinator.assembly.makeWorkoutDetailViewModel(
                for: session,
                onDismiss: onDismiss
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            WorkoutDetailView(
                viewModel: viewModel,
                nameSpace: nameSpace
            )
        }
        .navigationTransition(
            .zoom(
                sourceID: TransitionManager.detailTransitionId(for: viewModel.session.id),
                in: nameSpace
            )
        )
        .sheet(isPresented: $viewModel.isDetailInfoPresented) {
            DetailInfoView()
                .environmentObject(viewModel)
                .navigationTransition(
                    .zoom(
                        sourceID: TransitionManager.detailInfoTransitionId(for: viewModel.session.id),
                        in: nameSpace
                    )
                )
        }
        .sheet(isPresented: $viewModel.isDetailHeartRatePresented) {
            HeartRateView()
                .environmentObject(viewModel)
                .navigationTransition(
                    .zoom(
                        sourceID: TransitionManager.detailHeartRateTransitionId(for: viewModel.session.id),
                        in: nameSpace
                    )
                )
        }
        .sheet(isPresented: $viewModel.isGalleryPresented) {
            GalleryView(nameSpace: nameSpace)
                .environmentObject(viewModel)
                .navigationTransition(
                    .zoom(
                        sourceID: TransitionManager.galleryTransitionId(for: viewModel.session.id),
                        in: nameSpace
                    )
                )
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
        .sheet(isPresented: $viewModel.isMetricsInfoPresented) {
            MetricsView()
                .environmentObject(viewModel)
                .navigationTransition(
                    .zoom(
                        sourceID: TransitionManager.metricsTransitionId(for: viewModel.session.id),
                        in: nameSpace
                    )
                )
        }
        .alert(
            viewModel.errorTitle ?? "Unknown error",
            isPresented: $viewModel.shouldShowErrorAlert
        ) {
            Button("OK") { }
        }
    }
}

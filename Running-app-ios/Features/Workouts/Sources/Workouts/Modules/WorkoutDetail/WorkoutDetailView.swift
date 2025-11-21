//
//  SwiftUIView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 15/11/25.
//

import SwiftUI
import Common

struct WorkoutDetailView: View {
    
    @Namespace var nameSpace
    @StateObject var viewModel: WorkoutDetailViewModel
    private let onDismiss: () -> Void
    
    public init(
        viewModel: WorkoutDetailViewModel,
        onDismiss: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                WorkoutMap(
                    sessionRoute: viewModel.sessionRoute,
                    isInDetail: true
                )
                
                VStack {
                    Spacer()
                    HStack {
                        InfoButton(nameSpace: nameSpace)
                            .environmentObject(viewModel)
                        
                        GalleryButton(nameSpace: nameSpace)
                            .environmentObject(viewModel)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        onDismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .clipShape(Circle())
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isDetailInfoPresented) {
            DetailInfoView()
                .environmentObject(viewModel)
                .navigationTransition(
                    .zoom(
                        sourceID: WorkoutsCoordinator.detailInfoTransitionId(for: viewModel.session),
                        in: nameSpace
                    )
                )
        }
        .sheet(isPresented: $viewModel.isGalleryPresented) {
            GalleryView()
                .navigationTransition(
                    .zoom(
                        sourceID: WorkoutsCoordinator.galleryTransitionId(for: viewModel.session),
                        in: nameSpace
                    )
                )
        }
        .navigationTransition(
            .zoom(
                sourceID: WorkoutsCoordinator.detailTransitionId(for: viewModel.session),
                in: nameSpace
            )
        )
    }
}

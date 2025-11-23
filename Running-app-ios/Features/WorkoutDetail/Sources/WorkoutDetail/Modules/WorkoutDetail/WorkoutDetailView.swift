//
//  SwiftUIView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 15/11/25.
//

import SwiftUI
import Common

public struct WorkoutDetailView: View {
    
    @StateObject var viewModel: WorkoutDetailViewModel
    private let onDismiss: () -> Void
    var nameSpace: Namespace.ID

    public init(
        viewModel: WorkoutDetailViewModel,
        nameSpace: Namespace.ID,
        onDismiss: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.nameSpace = nameSpace
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
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
                        sourceID: TransitionManager.detailInfoTransitionId(for: viewModel.session.id),
                        in: nameSpace
                    )
                )
        }
        .sheet(isPresented: $viewModel.isGalleryPresented) {
            GalleryView()
                .navigationTransition(
                    .zoom(
                        sourceID: TransitionManager.galleryTransitionId(for: viewModel.session.id),
                        in: nameSpace
                    )
                )
        }
        .navigationTransition(
            .zoom(
                sourceID: TransitionManager.detailTransitionId(for: viewModel.session.id),
                in: nameSpace
            )
        )
    }
}

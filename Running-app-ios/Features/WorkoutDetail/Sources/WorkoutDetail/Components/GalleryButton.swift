//
//  GalleryButton.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 21/11/25.
//

import SwiftUI
import Common

struct GalleryButton: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel
    let nameSpace: Namespace.ID
    
    var body: some View {
        Button {
            viewModel.isGalleryPresented = true
        } label: {
            Image(systemName: "photo.stack")
                .padding(16)
                .contentShape(Circle())
                .clipShape(Circle())
                .glassEffect(.regular.interactive())
        }
        .buttonStyle(.plain)
        .matchedTransitionSource(
            id: TransitionManager.galleryTransitionId(for: viewModel.session.id),
            in: nameSpace
        )
    }
}

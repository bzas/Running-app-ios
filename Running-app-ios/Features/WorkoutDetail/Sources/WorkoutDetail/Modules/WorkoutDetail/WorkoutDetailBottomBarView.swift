//
//  WorkoutDetailBottomBarView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 24/11/25.
//

import SwiftUI
import Common
struct WorkoutDetailBottomBarView: View {

    @EnvironmentObject var viewModel: WorkoutDetailViewModel
    var nameSpace: Namespace.ID
    
    var body: some View {
        HStack(spacing: 8) {
            Button {
                // TODO: - Finish
            } label: {
                Image(systemName: "chart.xyaxis.line")
                    .font(.callout)
            }

            Button {
                viewModel.isDetailHeartRatePresented.toggle()
            } label: {
                Image(systemName: "heart")
                    .font(.callout)
            }
            .matchedTransitionSource(
                id: TransitionManager.detailHeartRateTransitionId(for: viewModel.session.id),
                in: nameSpace
            )
        }
        .padding(.horizontal, 8)
        
        Spacer()

        Button {
            viewModel.isDetailInfoPresented.toggle()
        } label: {
            VStack {
                Text(viewModel.session.name)
                    .bold()
                Text(WorkoutFormatter.distance(viewModel.session.distanceInKm))
                    .opacity(0.5)
            }
            .font(.footnote)
            .padding(.horizontal, 12)

        }
        .matchedTransitionSource(
            id: TransitionManager.detailInfoTransitionId(for: viewModel.session.id),
            in: nameSpace
        )
        
        Spacer()
        
        Button {
            viewModel.isGalleryPresented.toggle()
        } label: {
            Image(systemName: "photo.stack")
                .font(.callout)
        }
        .matchedTransitionSource(
            id: TransitionManager.galleryTransitionId(for: viewModel.session.id),
            in: nameSpace
        )
    }
}

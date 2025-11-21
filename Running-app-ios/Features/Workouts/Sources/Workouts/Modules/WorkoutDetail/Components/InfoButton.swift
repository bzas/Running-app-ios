//
//  InfoButton.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 21/11/25.
//

import SwiftUI

struct InfoButton: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel
    let nameSpace: Namespace.ID
    
    var body: some View {
        Button {
            viewModel.isDetailInfoPresented.toggle()
        } label: {
            HStack(spacing: 24) {
                Text(viewModel.session.name)
                    .bold()
                Text(WorkoutFormatter.distance(session: viewModel.session))
                    .opacity(0.5)
            }
            .font(.callout)
            .padding(.horizontal)
            .padding(.vertical, 16)
            .contentShape(Capsule())
            .clipShape(Capsule())
            .glassEffect(.regular.interactive())
        }
        .buttonStyle(.plain)
        .matchedTransitionSource(
            id: WorkoutsCoordinator.detailInfoTransitionId(for: viewModel.session),
            in: nameSpace
        )
    }
}

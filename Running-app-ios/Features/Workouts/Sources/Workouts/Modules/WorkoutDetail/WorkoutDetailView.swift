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
                    Button {
                        viewModel.isDetailInfoPresented = true
                    } label: {
                        HStack(spacing: 24) {
                            Text(viewModel.session.name)
                                .bold()
                            Text(WorkoutFormatter.distance(session: viewModel.session))
                                .opacity(0.5)
                        }
                        .font(.callout)
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .contentShape(Capsule())
                        .clipShape(Capsule())
                        .glassEffect(.regular.interactive())
                        .matchedTransitionSource(
                            id: WorkoutsCoordinator.detailInfoTransitionId(for: viewModel.session),
                            in: nameSpace
                        )
                    }
                    .buttonStyle(.plain)
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
            WorkoutDetailInfoView()
                .environmentObject(viewModel)
                .navigationTransition(
                    .zoom(
                        sourceID: WorkoutsCoordinator.detailInfoTransitionId(for: viewModel.session),
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

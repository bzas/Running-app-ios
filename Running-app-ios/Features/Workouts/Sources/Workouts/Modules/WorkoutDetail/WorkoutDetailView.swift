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
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: WorkoutDetailViewModel
    
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
                        viewModel.isDetailPresented = true
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
                        .matchedTransitionSource(id: viewModel.detailInfoTransitionId, in: nameSpace)
                    }
                    .buttonStyle(.plain)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .clipShape(Circle())
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.isDetailPresented) {
            WorkoutDetailInfoView()
                .environmentObject(viewModel)
                .navigationTransition(.zoom(sourceID: viewModel.detailInfoTransitionId, in: nameSpace))
        }
    }
}

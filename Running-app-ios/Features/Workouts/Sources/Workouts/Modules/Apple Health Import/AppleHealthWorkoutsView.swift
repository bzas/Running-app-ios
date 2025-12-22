//
//  AppleHealthWorkoutsView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import SwiftUI
import Common
import Localization

struct AppleHealthWorkoutsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: AppleHealthWorkoutsViewModel
    let nameSpace: Namespace.ID
    
    init(
        viewModel: AppleHealthWorkoutsViewModel,
        nameSpace: Namespace.ID
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.nameSpace = nameSpace
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.sessions) {
                        AppleHealthWorkoutCellView(
                            session: $0,
                            onImportSession: { viewModel.fetchComplete(session: $0) },
                            imported: viewModel.alreadyImportedSessions.contains($0.id)
                        )
                    }
                }
                .navigationTitle(Localizables.Workouts.healthWorkoutsTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchHealthWorkouts()
            }
        }
        .navigationTransition(
            .zoom(
                sourceID: TransitionManager.appleWorkoutsTransitionId(),
                in: nameSpace
            )
        )
    }
}

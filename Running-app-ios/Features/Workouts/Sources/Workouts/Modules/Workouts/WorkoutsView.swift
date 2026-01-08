//
//  WorkoutsView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import SwiftUI
import Localization
import Domain
import Common
import SwiftData

struct WorkoutsView: View {
    
    @Environment(\.modelContext) var context
    @StateObject var viewModel: WorkoutsViewModel
    let nameSpace: Namespace.ID
    private let onOpenSession: (WorkoutSession) -> Void
    private let onOpenFilePicker: () -> Void
    private let onOpenAppleWorkouts: () -> Void

    public init(
        viewModel: WorkoutsViewModel,
        nameSpace: Namespace.ID,
        onOpenSession: @escaping (WorkoutSession) -> Void,
        onOpenFilePicker: @escaping () -> Void,
        onOpenAppleWorkouts: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.nameSpace = nameSpace
        self.onOpenSession = onOpenSession
        self.onOpenFilePicker = onOpenFilePicker
        self.onOpenAppleWorkouts = onOpenAppleWorkouts
    }
    
    public var body: some View {
        Group {
            if viewModel.sessions.isEmpty {
                PlaceholderView(
                    isLoading: viewModel.isLoading,
                    type: .workouts
                )
            } else {
                List {
                    ForEach(viewModel.sessions) { session in
                        WorkoutRowView(
                            session: session,
                            nameSpace: nameSpace,
                            onTap: onOpenSession
                        )
                        .onAppear {
                            viewModel.loadMoreIfNeeded(currentItem: session)
                        }
                    }
                    .onDelete(perform: viewModel.deleteSessions)
                    .padding(.bottom)

                    if viewModel.isLoadingPage {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(Localizables.Workouts.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if !viewModel.isLoading {
                    Menu {
                        Button {
                            onOpenFilePicker()
                        } label: {
                            Label(Localizables.Workouts.garminFitFile, systemImage: "document.fill")
                        }
                        Button {
                            onOpenAppleWorkouts()
                        } label: {
                            Label("Apple Health", systemImage: "heart.fill")
                        }
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "plus")
                                .font(.footnote)
                            Text(Localizables.Common.add)
                        }
                        .padding(.horizontal, 6)
                    }
                    .matchedTransitionSource(
                        id: TransitionManager.appleWorkoutsTransitionId(),
                        in: nameSpace
                    )
                }
            }
        }
    }
}

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
    
    public init(
        viewModel: WorkoutsViewModel,
        nameSpace: Namespace.ID,
        onOpenSession: @escaping (WorkoutSession) -> Void,
        onOpenFilePicker: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.nameSpace = nameSpace
        self.onOpenSession = onOpenSession
        self.onOpenFilePicker = onOpenFilePicker
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
                    }
                    .onDelete(perform: viewModel.deleteSessions)
                    .padding(.bottom)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(Localizables.Workouts.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onOpenFilePicker()
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "plus")
                            .font(.footnote)
                        Text(Localizables.Common.add)
                    }
                    .padding(.horizontal, 6)
                }
            }
        }
    }
}

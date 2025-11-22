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

struct WorkoutsView: View {
    
    @StateObject var viewModel: WorkoutsViewModel
    private let onOpenSession: (WorkoutSession) -> Void
    private let onOpenFilePicker: () -> Void
    
    public init(
        viewModel: WorkoutsViewModel,
        onOpenSession: @escaping (WorkoutSession) -> Void,
        onOpenFilePicker: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onOpenSession = onOpenSession
        self.onOpenFilePicker = onOpenFilePicker
    }
    
    public var body: some View {
        Group {
            if viewModel.sessions.isEmpty {
                WorkoutsPlaceholderView()
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.sessions) { session in
                            WorkoutRowView(session: session) {
                                onOpenSession($0)
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle(Localizables.Workouts.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    onOpenFilePicker()
                } label: {
                    Image(systemName: "plus")
                        .clipShape(Circle())
                }
            }
        }
    }
}

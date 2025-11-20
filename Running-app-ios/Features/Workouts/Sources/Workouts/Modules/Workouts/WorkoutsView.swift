//
//  WorkoutsView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import SwiftUI
import Localization
import Domain

struct WorkoutsView: View {
    
    @StateObject var viewModel: WorkoutsViewModel
    private let onOpenSession: (WorkoutSession) -> Void
    
    public init(
        viewModel: WorkoutsViewModel,
        onOpenSession: @escaping (WorkoutSession) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onOpenSession = onOpenSession
        viewModel.loadTestActivity()
    }
    
    public var body: some View {
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
        .navigationTitle(Localizables.Workouts.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    print("Add")
                } label: {
                    Image(systemName: "plus")
                        .clipShape(Circle())
                }
            }
        }
    }
}

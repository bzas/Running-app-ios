//
//  WorkoutsView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import SwiftUI
import Localization

public struct WorkoutsView: View {
    
    @EnvironmentObject var viewModel: WorkoutsViewModel
    
    public init() {}
    
    public var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.sessions) { session in
                        WorkoutRowView(session: session)
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
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Search")
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .clipShape(Circle())
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadTestActivity()
        }
    }
}

//
//  SearchView.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI
import Common
import Localization
import Domain

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    var nameSpace: Namespace.ID
    
    private let onOpenSession: (WorkoutSession) -> Void
    
    init(
        viewModel: SearchViewModel,
        nameSpace: Namespace.ID,
        onOpenSession: @escaping (WorkoutSession) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.nameSpace = nameSpace
        self.onOpenSession = onOpenSession
    }
    
    var body: some View {
        Group {
            if viewModel.sessions.isEmpty {
                PlaceholderView(
                    isLoading: viewModel.isLoading,
                    type: .workouts
                )
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.sessions) { session in
                            SearchRowView(
                                session: session,
                                nameSpace: nameSpace,
                                onTap: onOpenSession
                            )
                        }
                    }
                    .padding()
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle(Localizables.Search.title)
        .toolbarTitleDisplayMode(.inline)
        .searchable(text: $viewModel.searchText)
        .onAppear {
            viewModel.fetchAll()
        }
        .onChange(of: viewModel.searchText) {
            viewModel.applyFilters()
        }
    }
}

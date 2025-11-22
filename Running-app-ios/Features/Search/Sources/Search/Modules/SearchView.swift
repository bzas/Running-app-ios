//
//  SearchView.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI
import Common

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            if viewModel.sessions.isEmpty {
                WorkoutsPlaceholderView()
            } else {
                Text("Search")
            }
        }
        .searchable(text: $viewModel.searchText)
    }
}

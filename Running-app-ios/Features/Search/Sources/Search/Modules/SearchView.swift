//
//  SearchView.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text("Search")
            .searchable(text: $viewModel.searchText)
    }
}

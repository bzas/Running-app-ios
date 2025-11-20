//
//  SearchRootView.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import SwiftUI

struct SearchRootView: View {
    
    @ObservedObject var coordinator: SearchCoordinator
    
    var body: some View {
        NavigationStack {
            SearchView(
                viewModel: coordinator.assembly.makeSearchViewModel()
            )
        }
    }
}

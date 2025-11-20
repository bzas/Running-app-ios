//
//  SearchViewModel.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import Foundation

@MainActor
public final class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    
    public init() {}
}

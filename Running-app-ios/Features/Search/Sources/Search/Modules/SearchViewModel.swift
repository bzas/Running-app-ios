//
//  SearchViewModel.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import Foundation
import Domain

@MainActor
public final class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var sessions: [WorkoutSession] = []
    
    public init() {}
}

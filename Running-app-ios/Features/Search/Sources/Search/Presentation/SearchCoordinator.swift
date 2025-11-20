//
//  SearchCoordinator.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 20/11/25.
//

import Foundation
import SwiftUI

@MainActor
public final class SearchCoordinator: ObservableObject {
 
    let assembly: SearchAssemblyProtocol
    
    public init(assembly: SearchAssemblyProtocol) {
        self.assembly = assembly
    }
    
    @ViewBuilder
    public func rootView() -> some View {
        SearchRootView(coordinator: self)
    }
}

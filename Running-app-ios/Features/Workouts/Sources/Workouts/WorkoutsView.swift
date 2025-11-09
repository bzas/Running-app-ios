//
//  SwiftUIView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import SwiftUI

public struct WorkoutsView: View {
    
    @StateObject var viewModel: WorkoutsViewModel

    public init() {
        _viewModel = StateObject(wrappedValue: WorkoutsViewModel())
    }
    
    public var body: some View {
        Text("Workouts")
    }
}

#Preview {
    WorkoutsView()
}

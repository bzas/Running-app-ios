//
//  SwiftUIView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import SwiftUI

public struct WorkoutsView: View {
    
    @EnvironmentObject var viewModel: WorkoutsViewModel
    
    public init() {}
    
    public var body: some View {
        VStack {
            List {
                Section(header: Text("Activities")) {
                    ForEach(viewModel.sessions) { session in
                        WorkoutCellView(
                            viewModel: WorkoutCellViewModel(session: session)
                        )
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadTestActivity()
        }
    }
}

//
//  ElevationSummaryView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 25/11/25.
//

import SwiftUI
import Common

struct ElevationSummaryView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Maximum altitude")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(WorkoutFormatter.elevation(viewModel.maxAltitude))
                    .bold()
            }
            
            HStack {
                Text("Minimum altitude")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(WorkoutFormatter.elevation(viewModel.minAltitude))
                    .bold()
            }
        }
        .font(.callout)
    }
}

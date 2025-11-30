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
                Text(DataFormatter.elevation(viewModel.maxAltitude))
                    .fontWeight(.semibold)
            }
            
            HStack {
                Text("Minimum altitude")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(DataFormatter.elevation(viewModel.minAltitude))
                    .fontWeight(.semibold)
            }
        }
        .font(.callout)
    }
}

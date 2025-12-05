//
//  ElevationSummaryView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 25/11/25.
//

import SwiftUI
import Common
import Localization

struct ElevationSummaryView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(Localizables.WorkoutDetail.Elevation.maxAltitude)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(DataFormatter.elevation(viewModel.maxAltitude))
                    .fontWeight(.semibold)
            }
            
            HStack {
                Text(Localizables.WorkoutDetail.Elevation.minAltitude)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(DataFormatter.elevation(viewModel.minAltitude))
                    .fontWeight(.semibold)
            }
        }
        .font(.callout)
    }
}

//
//  HeartRateSummaryView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Domain
import Common
import Localization

struct HeartRateSummaryView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(Localizables.WorkoutDetail.HeartRateSummary.average)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(DataFormatter.heartRate(viewModel.session.heartRate))
                    .fontWeight(.semibold)
            }
            
            HStack {
                Text(Localizables.WorkoutDetail.HeartRateSummary.maximum)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(DataFormatter.heartRate(viewModel.session.maxHeartRate))
                    .fontWeight(.semibold)
            }
        }
        .font(.callout)
    }
}

//
//  HeartRateSummaryView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Domain
import Common

struct HeartRateSummaryView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Average heart rate")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(DataFormatter.heartRate(viewModel.session.heartRate))
                    .bold()
            }
            
            HStack {
                Text("Maximum heart rate")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(DataFormatter.heartRate(viewModel.session.maxHeartRate))
                    .bold()
            }
        }
        .font(.callout)
    }
}

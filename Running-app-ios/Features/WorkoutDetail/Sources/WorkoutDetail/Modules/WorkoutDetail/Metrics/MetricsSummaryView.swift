//
//  MetricsSummaryView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 26/11/25.
//

import SwiftUI
import Common
import Domain
import Localization

struct MetricsSummaryView: View {
    
    let session: WorkoutSession

    var body: some View {
        HStack {
            if let cadence = session.cadence {
                VStack(alignment: .leading){
                    Text(Localizables.WorkoutDetail.Metrics.cadence)
                        .font(.caption2)
                    Text(DataFormatter.cadence(cadence))
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            
            
            if let verticalOscillation = session.verticalOscillation {
                VStack(alignment: .leading) {
                    Text(Localizables.WorkoutDetail.Metrics.verticalOscillation)
                        .font(.caption2)
                    Text(DataFormatter.verticalOscillation(verticalOscillation))
                        .fontWeight(.semibold)
                }
                Spacer()
            }
            
            if let groundContactTime = session.groundContactTime {
                VStack(alignment: .leading) {
                    Text(Localizables.WorkoutDetail.Metrics.groundContactTime)
                        .font(.caption2)
                    Text(DataFormatter.groundContactTime(groundContactTime))
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

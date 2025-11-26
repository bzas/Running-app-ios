//
//  MetricsSummaryView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 26/11/25.
//

import SwiftUI
import Common
import Domain

struct MetricsSummaryView: View {
    
    @State var session: WorkoutSession

    var body: some View {
        HStack {
            if let cadence = session.cadence {
                VStack(alignment: .leading){
                    Text("Cadence")
                        .font(.caption2)
                    Text(WorkoutFormatter.cadence(cadence))
                        .bold()
                }
                Spacer()
            }
            
            
            if let verticalOscillation = session.verticalOscillation {
                VStack(alignment: .leading) {
                    Text("Vertical Oscillation")
                        .font(.caption2)
                    Text(WorkoutFormatter.verticalOscillation(verticalOscillation))
                        .bold()
                }
                Spacer()
            }
            
            if let groundContactTime = session.groundContactTime {
                VStack(alignment: .leading) {
                    Text("Ground Contact Time")
                        .font(.caption2)
                    Text(WorkoutFormatter.groundContactTime(groundContactTime))
                        .bold()
                }
            }
        }
    }
}

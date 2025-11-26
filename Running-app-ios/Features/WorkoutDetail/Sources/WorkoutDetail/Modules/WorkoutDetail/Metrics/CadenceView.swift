//
//  CadenceView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 26/11/25.
//

import SwiftUI
import Charts
import Common

struct CadenceView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel

    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Cadence")
                    .font(.body)
                    .bold()
                Spacer()
            }
            
            Chart {
                ForEach(viewModel.cadenceChartData) { data in
                    AreaMark(
                        x: .value("", data.label),
                        yStart: .value("", viewModel.cadenceChartRange.lowerBound),
                        yEnd: .value("", data.value)
                    )
                }
                .interpolationMethod(.cardinal)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
                
                if let cadence = viewModel.session.cadence {
                    RuleMark(
                        y: .value(
                            WorkoutFormatter.cadence(cadence),
                            cadence
                        )
                    )
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundStyle(Color(uiColor: .label))
                    .annotation(position: .top,
                                alignment: .center) {
                        Text(WorkoutFormatter.cadence(cadence))
                            .font(.caption)
                            .foregroundStyle(Color(uiColor: .label))
                    }
                }
            }
            .chartYScale(domain: viewModel.cadenceChartRange)
            .chartXAxis(.hidden)
            .frame(height: 150)
        }
        .padding(.top)
    }
}

//
//  PaceView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import SwiftUI
import Domain
import Charts
import Common

struct PaceView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel
    
    var body: some View {
        Chart {
            ForEach(viewModel.paceChartData) { point in
                BarMark(
                    x: .value("", point.label),
                    yStart: .value("", viewModel.paceChartRange.lowerBound),
                    yEnd: .value("", point.value)
                )
            }
            
            RuleMark(
                y: .value(
                    WorkoutFormatter.pace(seconds: viewModel.session.paceInSeconds),
                    viewModel.session.paceInSeconds
                )
            )
            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundStyle(Color(uiColor: .label))
            .opacity(0.75)
            .annotation(position: .top,
                        alignment: .center) {
                Text(WorkoutFormatter.pace(seconds: viewModel.session.paceInSeconds))
                    .font(.caption2)
                    .opacity(0.75)
            }
        }
        .chartXAxis(viewModel.paceChartData.count <= 12 ? .automatic : .hidden)
        .chartYScale(domain: viewModel.paceChartRange)
        .chartYAxis {
            AxisMarks(values: .stride(by: viewModel.paceChartStrideValue)) { value in
                AxisGridLine()
                AxisValueLabel {
                    if let seconds = value.as(Double.self) {
                        Text(WorkoutFormatter.pace(seconds: seconds))
                            .font(.caption2)
                    }
                }
            }
        }
        .frame(height: 150)
    }
}

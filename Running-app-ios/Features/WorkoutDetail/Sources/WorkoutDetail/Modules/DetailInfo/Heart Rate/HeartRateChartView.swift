//
//  HeartRateChartView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Charts

struct HeartRateChartView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel
    
    private let linearGradient = LinearGradient(
        gradient: Gradient(
            colors: [
                Color.red.opacity(0.5),
                Color.red.opacity(0.1)
            ]
        ),
        startPoint: .top,
        endPoint: .bottom
    )
    
    var body: some View {
        Chart {
            ForEach(viewModel.hrChartData) { data in
                LineMark(
                    x: .value("", data.label),
                    y: .value("", data.value)
                )
            }
            .foregroundStyle(.red)
            
            ForEach(viewModel.hrChartData) { data in
                AreaMark(
                    x: .value("", data.label),
                    yStart: .value("", viewModel.hrChartRange.lowerBound),
                    yEnd: .value("", data.value)
                )
            }
            .interpolationMethod(.cardinal)
            .foregroundStyle(linearGradient)
        }
        .chartYScale(domain: viewModel.hrChartRange)
        .chartXAxis(.hidden)
        .frame(height: 150)
    }
}

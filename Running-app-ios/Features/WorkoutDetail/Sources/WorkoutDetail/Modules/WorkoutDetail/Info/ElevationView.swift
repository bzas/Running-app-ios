//
//  ElevationView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 25/11/25.
//

import SwiftUI
import Charts

struct ElevationView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Elevation")
                    .font(.body)
                    .bold()
                Spacer()
            }
            
            Chart {
                ForEach(viewModel.elevationChartData) { data in
                    AreaMark(
                        x: .value("", data.label),
                        yStart: .value("", viewModel.elevationChartRange.lowerBound),
                        yEnd: .value("", data.value)
                    )
                }
                .interpolationMethod(.cardinal)
                .foregroundStyle(Color(uiColor: .secondaryLabel))
            }
            .chartYScale(domain: viewModel.elevationChartRange)
            .chartXAxis(.hidden)
            .frame(height: 150)
            
            ElevationSummaryView()
                .environmentObject(viewModel)
        }
        .padding(.top)
    }
}

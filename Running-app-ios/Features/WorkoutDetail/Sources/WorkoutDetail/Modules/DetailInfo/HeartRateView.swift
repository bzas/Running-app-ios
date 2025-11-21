//
//  HeartRateView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import SwiftUI
import Charts
import Domain
import Common

struct HeartRateView: View {

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
        VStack {
            HStack {
                Text("Heart Rate")
                    .font(.title2)
                Spacer()
            }
            
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
            
            VStack(spacing: 12) {
                HStack {
                    Text("Average heart rate")
                        .opacity(0.75)
                    Spacer()
                    Text(WorkoutFormatter.heartRate(viewModel.session.heartRate))
                        .bold()
                }
                
                HStack {
                    Text("Maximum heart rate")
                        .opacity(0.75)
                    Spacer()
                    Text(WorkoutFormatter.heartRate(viewModel.session.maxHeartRate))
                        .bold()
                }
            }
            .font(.footnote)
            .padding(.trailing, 32)
            .padding(.top, 16)
        }
    }
}

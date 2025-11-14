//
//  SwiftUIView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import SwiftUI

struct WorkoutCellView: View {
    
    @StateObject var viewModel: WorkoutCellViewModel
    
    init(viewModel: WorkoutCellViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.session.name)
                .font(.headline)
            
            Text(viewModel.session.timestamp?.description ?? "")
                .font(.caption)
            
            HStack {
                if let heartRate = viewModel.session.heartRate {
                    VStack {
                        Text("Heart Rate")
                        Text("\(heartRate) bpm")
                    }
                }
                
                VStack {
                    Text("Distance")
                    Text(String(format: "%.2fm", viewModel.session.distance))
                }
            }
            .font(.subheadline)
        }
    }
}

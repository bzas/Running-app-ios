//
//  SwiftUIView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import SwiftUI
import MapKit

struct WorkoutCellView: View {
    
    @StateObject var viewModel: WorkoutCellViewModel
    
    init(viewModel: WorkoutCellViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.session.name)
                    .font(.title2)
                
                Text(viewModel.session.timestamp?.formatted() ?? "")
                    .font(.caption)
                
                HStack {
                    VStack {
                        Text("Pace")
                            .font(.caption2)
                        Text(viewModel.pace)
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Distance")
                            .font(.caption2)
                        Text(viewModel.distance)
                            .bold()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Heart Rate")
                            .font(.caption2)
                        Text(viewModel.heartRate)
                            .bold()
                    }
                }
                .font(.subheadline)
                .padding(.top)
            }
            .padding(.horizontal)

            Map(
                initialPosition: .region(viewModel.mapRegion),
                interactionModes: []
            ) {
                MapPolyline(coordinates: viewModel.sessionRoute)
                    .stroke(.primary, lineWidth: 2)
            
                if let startPoint = viewModel.sessionRoute.first {
                    Marker("Start", coordinate: startPoint).tint(.primary)
                }
                
                if let finishPoint = viewModel.sessionRoute.last {
                    Marker("Finish", coordinate: finishPoint).tint(.primary)
                }
            }
            .frame(height: 200)
            .cornerRadius(10)
        }
    }
}


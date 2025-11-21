//
//  WorkoutSummaryView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import SwiftUI

public struct WorkoutSummaryView: View {
    
    @State var paceInSeconds: Double
    @State var distance: Double
    @State var time: Double

    public init(
        paceInSeconds: Double,
        distance: Double,
        time: Double
    ) {
        self.paceInSeconds = paceInSeconds
        self.distance = distance
        self.time = time
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Pace")
                    .font(.caption2)
                Text(WorkoutFormatter.pace(seconds: paceInSeconds))
                    .bold()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Distance")
                    .font(.caption2)
                Text(WorkoutFormatter.distance(distance))
                    .bold()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Time")
                    .font(.caption2)
                Text(WorkoutFormatter.time(time))
                    .bold()
            }
        }
    }
}

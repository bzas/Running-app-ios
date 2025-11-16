//
//  WorkoutSummaryView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import SwiftUI
import Domain

struct WorkoutSummaryView: View {
    
    @State var session: WorkoutSession
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Pace")
                    .font(.caption2)
                Text(WorkoutFormatter.pace(session: session))
                    .bold()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Distance")
                    .font(.caption2)
                Text(WorkoutFormatter.distance(session: session))
                    .bold()
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Time")
                    .font(.caption2)
                Text(WorkoutFormatter.time(session: session))
                    .bold()
            }
        }
    }
}

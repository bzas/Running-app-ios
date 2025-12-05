//
//  WorkoutSummaryView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import SwiftUI
import Localization

public struct WorkoutSummaryView: View {
    
    let paceInSeconds: Double
    let distance: Double
    let time: Double

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
                Text(Localizables.Common.pace)
                    .font(.caption2)
                Text(DataFormatter.pace(seconds: paceInSeconds))
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(Localizables.Common.distance)
                    .font(.caption2)
                Text(DataFormatter.distance(distance))
                    .fontWeight(.semibold)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(Localizables.Common.time)
                    .font(.caption2)
                Text(DataFormatter.time(time))
                    .fontWeight(.semibold)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(
            String(
                format: Localizables.Accessibility.workoutSummary,
                DataFormatter.pace(seconds: paceInSeconds),
                DataFormatter.distance(distance),
                DataFormatter.time(time)
            )
        )
    }
}

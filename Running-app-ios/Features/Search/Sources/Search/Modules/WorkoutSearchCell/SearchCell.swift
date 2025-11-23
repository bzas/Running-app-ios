//
//  SearchCell.swift
//  Search
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Common
import Domain
import MapKit

struct SearchCell: View {
    
    @State var session: WorkoutSession
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(session.name)
                    .font(.body)
                
                Text(WorkoutFormatter.distance(session.distanceInKm))
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(session.timestamp?.formatted() ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Spacer()
                
                Text(WorkoutFormatter.time(session.totalTime))
                    .font(.callout)
            }
        }
        .padding()
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(
            RoundedRectangle(
                cornerSize: CGSize(
                    width: 10,
                    height: 10
                )
            )
        )
    }
}

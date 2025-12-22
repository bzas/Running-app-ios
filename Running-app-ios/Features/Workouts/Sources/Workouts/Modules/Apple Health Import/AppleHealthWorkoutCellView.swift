//
//  AppleHealthWorkoutCellView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import SwiftUI
import Domain
import Common

struct AppleHealthWorkoutCellView: View {
    
    var session: WorkoutSession
    var onImportSession: (WorkoutSession) -> Void
    @State var imported = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(session.name)
                Text(DataFormatter.distance(session.distanceInKm))
                    .foregroundStyle(.secondary)
                    .font(.callout)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(session.timestamp?.formatted() ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(DataFormatter.time(session.totalTime))
            }
            
            Button {
                didTapImport()
            } label: {
                if imported {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(.title, weight: .light))
                        .foregroundStyle(.blue)
                } else {
                    Image(systemName: "arrow.down.circle")
                        .font(.system(.title, weight: .light))
                        .foregroundStyle(.secondary)
                }
            }
            .buttonStyle(.plain)
            .padding(.leading)
        }
        .padding()
        .padding(.horizontal)
    }
    
    func didTapImport() {
        guard !imported else { return }
        onImportSession(session)
        imported = true
    }
}

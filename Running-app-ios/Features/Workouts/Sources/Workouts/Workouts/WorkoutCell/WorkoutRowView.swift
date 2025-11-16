//
//  WorkoutRowView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 15/11/25.
//

import SwiftUI
import Domain

struct WorkoutRowView: View {
    
    @Namespace var nameSpace
    @State private var isDetailPresented = false
    
    let session: WorkoutSession
    let detailTransitionId = "detailTransition"

    var body: some View {
        Button {
            isDetailPresented.toggle()
        } label: {
            WorkoutCellView()
                .environmentObject(WorkoutCellViewModel(session: session))
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .matchedTransitionSource(id: detailTransitionId + session.id.uuidString, in: nameSpace)
        .fullScreenCover(isPresented: $isDetailPresented) {
            WorkoutDetailView()
                .environmentObject(WorkoutDetailViewModel(session: session))
                .navigationTransition(.zoom(sourceID: detailTransitionId + session.id.uuidString, in: nameSpace))
        }
    }
}

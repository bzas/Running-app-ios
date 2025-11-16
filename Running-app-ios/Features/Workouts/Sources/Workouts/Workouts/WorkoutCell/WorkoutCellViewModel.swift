//
//  WorkoutCellViewModel.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 16/11/25.
//

import Foundation
import Domain
import MapKit

@MainActor
public final class WorkoutCellViewModel: ObservableObject {
    
    @Published var session: WorkoutSession
    @Published var sessionRoute: [CLLocationCoordinate2D] = []
    
    init(session: WorkoutSession) {
        self.session = session
        setup()
    }
}

// MARK: - Private methods

private extension WorkoutCellViewModel {
    
    func setup() {
        sessionRoute = session.sessionTrackPoints.map { point in
            CLLocationCoordinate2D(
                latitude: point.latitude,
                longitude: point.longitude
            )
        }
    }
}

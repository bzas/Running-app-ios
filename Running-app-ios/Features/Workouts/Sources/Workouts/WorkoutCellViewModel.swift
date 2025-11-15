//
//  File.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation
import Domain
import MapKit

@MainActor
final class WorkoutCellViewModel: ObservableObject {
    @Published var session: WorkoutSession
    @Published var mapRegion = MKCoordinateRegion()
    @Published var sessionRoute: [CLLocationCoordinate2D] = []
    
    init(session: WorkoutSession) {
        self.session = session
        setup()
    }
    
    var pace: String {
        guard session.paceInSeconds > 0 else { return "--:--" }
        
        let m = Int(session.paceInSeconds) / 60
        let s = Int(session.paceInSeconds) % 60
        return "\(m):\(String(format: "%02d", s)) /km"
    }
    
    var distance: String {
        String(format: "%.2f km", session.distanceInKm)
    }
    
    var heartRate: String {
        guard let heartRateValue = session.heartRate else { return "- bpm"}
        return "\(heartRateValue) bpm"
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
        
        calculateRegion()
    }
    
    func calculateRegion() {
        guard !sessionRoute.isEmpty else {
            return
        }

        let edgePaddingMeters = 250.0
        let latitudes = sessionRoute.map { $0.latitude }
        let longitudes = sessionRoute.map { $0.longitude }

        let minLatitude = latitudes.min()!
        let maxLatitude = latitudes.max()!
        let minLongitude = longitudes.min()!
        let maxLongitude = longitudes.max()!

        let center = CLLocationCoordinate2D(
            latitude: (minLatitude + maxLatitude) / 2,
            longitude: (minLongitude + maxLongitude) / 2
        )

        let latDeltaDegrees = maxLatitude - minLatitude
        let lonDeltaDegrees = maxLongitude - minLongitude

        let latMeters = latDeltaDegrees * 111_000.0 + edgePaddingMeters * 2
        let lonMeters = lonDeltaDegrees * 111_000.0 * cos(center.latitude * .pi / 180) + edgePaddingMeters * 2

        mapRegion = MKCoordinateRegion(
            center: center,
            latitudinalMeters: max(500, latMeters),
            longitudinalMeters: max(500, lonMeters)
        )
    }
}

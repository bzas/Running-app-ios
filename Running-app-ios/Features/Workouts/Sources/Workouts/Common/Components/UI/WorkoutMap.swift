//
//  WorkoutMap.swift
//
//  Created by Alfonso Boizas Crespo on 15/11/25.
//

import SwiftUI
import MapKit

struct WorkoutMap: View {
    
    var mapRegion = MKCoordinateRegion()
    var sessionRoute: [CLLocationCoordinate2D]
    var isInDetail: Bool
    var moveRegion: Bool
    let edgePaddingMeters = 200.0

    init(
        sessionRoute: [CLLocationCoordinate2D],
        isInDetail: Bool = false,
        moveRegion: Bool = false
    ) {
        self.sessionRoute = sessionRoute
        self.isInDetail = isInDetail
        self.moveRegion = moveRegion
        self.mapRegion = calculateRegion()
    }
    
    var body: some View {
        Map(
            initialPosition: .region(mapRegion),
            interactionModes: isInDetail ? .all : []
        ) {
            MapPolyline(coordinates: sessionRoute)
                .stroke(.blue, lineWidth: isInDetail ? 5 : 3)
        
            if let startPoint = sessionRoute.first {
                Marker("Start", coordinate: startPoint).tint(.blue)
            }
            
            if let finishPoint = sessionRoute.last {
                Marker("Finish", coordinate: finishPoint).tint(.blue)
            }
        }
        .mapStyle(.standard(pointsOfInterest: .excludingAll))
    }
}

// MARK: - Private methods

private extension WorkoutMap {
    
    func calculateRegion() -> MKCoordinateRegion {
        guard !sessionRoute.isEmpty else {
            return MKCoordinateRegion()
        }

        let latitudes = sessionRoute.map { $0.latitude }
        let longitudes = sessionRoute.map { $0.longitude }

        let minLatitude = latitudes.min()!
        let maxLatitude = latitudes.max()!
        let minLongitude = longitudes.min()!
        let maxLongitude = longitudes.max()!

        var center = CLLocationCoordinate2D(
            latitude: (minLatitude + maxLatitude) / 2,
            longitude: (minLongitude + maxLongitude) / 2
        )

        let latDeltaDegrees = maxLatitude - minLatitude
        let lonDeltaDegrees = maxLongitude - minLongitude

        let latMeters = latDeltaDegrees * 111_000.0 + edgePaddingMeters * 2
        let lonMeters = lonDeltaDegrees * 111_000.0 * cos(center.latitude * .pi / 180) + edgePaddingMeters * 2
        
        if moveRegion {
            let shiftMeters = latMeters * 0.4
            let shiftDegrees = shiftMeters / 111_000.0
            center.latitude -= shiftDegrees
            center.latitude = min(max(center.latitude, -90), 90)
        }

        return MKCoordinateRegion(
            center: center,
            latitudinalMeters: max(500, latMeters),
            longitudinalMeters: max(500, lonMeters)
        )
    }
}

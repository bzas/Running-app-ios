//
//  WorkoutDetailViewModel.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation
import Domain
import MapKit

@MainActor
public final class WorkoutDetailViewModel: ObservableObject {
    
    @Published var session: WorkoutSession
    @Published var sessionRoute: [CLLocationCoordinate2D] = []
    
    // MARK: Sheet presentation
    
    @Published var isDetailInfoPresented = false
    @Published var isGalleryPresented = false

    // MARK: - Pace
    
    @Published var paceChartData: [ChartData] = []
    @Published var paceChartRange: ClosedRange<Double> = 120.0...600.0
    
    // MARK: Heart Rate
    
    @Published var hrChartData: [ChartData] = []
    @Published var hrValues: [Int] = []
    @Published var hrChartRange: ClosedRange<Double> = 0.0...220.0

    public init(session: WorkoutSession) {
        self.session = session
        setup()
    }
}

// MARK: - Private methods

private extension WorkoutDetailViewModel {
    
    func setup() {
        calculateRouteInfo()
        
        Task {
            self.calculatePaceInfo()
            self.calculateHRInfo()
        }
    }
    
    func calculateRouteInfo() {
        sessionRoute = session.sessionTrackPoints.map { point in
            CLLocationCoordinate2D(
                latitude: point.latitude,
                longitude: point.longitude
            )
        }
    }
    
    func calculatePaceInfo() {
        self.paceChartData = session.paceInSecondsPerKm.enumerated().map {
            ChartData(
                label: "\($0.offset + 1)",
                value: $0.element
            )
        }
        
        let minVal = session.paceInSecondsPerKm.min() ?? 0.0
        let maxVal = session.paceInSecondsPerKm.max() ?? 0.0
        
        let lower = max(0.0, minVal - 20.0)
        let upper = maxVal + 10.0
        self.paceChartRange = (lower < upper) ? (lower...upper) : (lower...lower + 1.0)
    }
    
    func calculateHRInfo() {
        for index in stride(from: 0, to: session.sessionTrackPoints.count, by: 20) {
            if let heartRate = session.sessionTrackPoints[index].heartRate {
                hrValues.append(heartRate)
                hrChartData.append(
                    ChartData(
                        label: "\(index + 1)",
                        value: Double(heartRate)
                    )
                )
            }
        }
        
        let minVal = Double(session.minHeartRate ?? 40)
        let maxVal = Double(session.maxHeartRate ?? 240)
        
        let lower = max(0.0, minVal)
        let upper = maxVal + 20.0
        hrChartRange = (lower < upper) ? (lower...upper) : (lower...lower + 1.0)
    }
}

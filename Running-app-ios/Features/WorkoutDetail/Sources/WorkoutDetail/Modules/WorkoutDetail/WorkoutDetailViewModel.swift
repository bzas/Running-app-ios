//
//  WorkoutDetailViewModel.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation
import Domain
import MapKit
import Common
import Application
import _PhotosUI_SwiftUI

@MainActor
public final class WorkoutDetailViewModel: ObservableObject {
    
    @Published var session: WorkoutSession
    
    // MARK: - Presentation
    
    @Published var isDetailInfoPresented = false
    @Published var isDetailHeartRatePresented = false
    @Published var isMetricsInfoPresented = false
    var onDismiss: () -> Void
    
    // MARK: - Use case
    
    private var getUserUseCase: GetUserUseCase
    private var galleryUseCase: GalleryUseCase

    // MARK: - Gallery
    
    @Published var isGalleryPresented = false
    @Published var selectedPhoto: PhotosPickerItem?
    @Published var presentedPhoto: SessionPhoto?

    // MARK: - Pace
    
    @Published var paceChartData: [ChartData] = []
    @Published var paceChartRange: ClosedRange<Double> = 120.0...600.0
    @Published var paceChartStrideValue = 0.0
    
    // MARK: - Elevation
    
    @Published var elevationChartData: [ChartData] = []
    @Published var elevationValues: [Int] = []
    @Published var elevationChartRange: ClosedRange<Double> = 0.0...3000.0
    @Published var maxAltitude: Double = 0.0
    @Published var minAltitude: Double = 0.0
    
    // MARK: Heart Rate
    
    @Published var hrChartData: [ChartData] = []
    @Published var hrValues: [Int] = []
    @Published var hrChartRange: ClosedRange<Double> = 0.0...220.0
    @Published var heartRateZonesInfo: [SessionHeartRateZone] = []
    
    // MARK: - Cadence
    
    @Published var cadenceChartData: [ChartData] = []
    @Published var cadenceValues: [Int] = []
    @Published var cadenceChartRange: ClosedRange<Double> = 0.0...220.0
    @Published var maxCadence: Double = 0.0
    @Published var minCadence: Double = 0.0
    
    public init(
        session: WorkoutSession,
        getUserUseCase: GetUserUseCase,
        galleryUseCase: GalleryUseCase,
        onDismiss: @escaping () -> Void
    ) {
        self.session = session
        self.getUserUseCase = getUserUseCase
        self.galleryUseCase = galleryUseCase
        self.onDismiss = onDismiss
        setup()
    }
    
    func storePhoto() {
        guard let selectedPhoto else { return }
        
        Task {
            do {
                if let data = try await selectedPhoto.loadTransferable(type: Data.self) {
                    session.photos.append(
                        SessionPhoto(data: data)
                    )
                    try await galleryUseCase.updatePhotos(session)
                }
            } catch {
                print(error.localizedDescription)
            }
            
            self.selectedPhoto = nil
        }
    }
    
    func deletePhoto(_ photo: SessionPhoto) {
        Task {
            do {
                session.photos.removeAll {
                    $0.id == photo.id
                }
                try await galleryUseCase.updatePhotos(session)
                presentedPhoto = nil
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - Private methods

private extension WorkoutDetailViewModel {
    
    func setup() {        
        Task {
            await calculateHeartRateZones()
            calculatePaceInfo()
            createChartsData()
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
        
        let tempStride = abs(maxVal - minVal) / 3
        self.paceChartStrideValue = ceil(tempStride / 15.0) * 15.0

        let lower = max(0.0, minVal - 20.0)
        let upper = maxVal + 10.0
        
        self.paceChartRange = (lower < upper) ? (lower...upper) : (lower...lower + 1.0)
    }
    
    func createChartsData() {
        maxAltitude = 0
        minAltitude = 10000
        
        maxCadence = 0
        minCadence = 220
        
        for index in stride(from: 0, to: session.sessionTrackPoints.count, by: 20) {
            addAltitude(at: index)
            addHeartRate(at: index)
            addCadence(at: index)
        }
        
        setElevationChart()
        setHeartRateChart()
        setCadenceChart()
    }
    
    func addAltitude(at index: Int) {
        guard let altitude = session.sessionTrackPoints[index].altitude else { return }
        
        if altitude < minAltitude {
            minAltitude = altitude
        }
        if altitude > maxAltitude {
            maxAltitude = altitude
        }
        
        elevationValues.append(Int(altitude))
        elevationChartData.append(
            ChartData(
                label: "\(index + 1)",
                value: altitude
            )
        )
    }
    
    func addHeartRate(at index: Int) {
        guard let heartRate = session.sessionTrackPoints[index].heartRate else { return }
        
        hrValues.append(heartRate)
        hrChartData.append(
            ChartData(
                label: "\(index + 1)",
                value: Double(heartRate)
            )
        )
    }
    
    func addCadence(at index: Int) {
        guard let cadenceInt = session.sessionTrackPoints[index].cadence else { return }
        
        let cadence = Double(cadenceInt)
        
        if cadence < minCadence {
            minCadence = cadence
        }
        if cadence > maxCadence {
            maxCadence = cadence
        }
        
        cadenceValues.append(cadenceInt)
        cadenceChartData.append(
            ChartData(
                label: "\(index + 1)",
                value: Double(cadence)
            )
        )
    }
    
    func setCadenceChart() {
        cadenceChartRange = (minCadence < maxCadence) ? (minCadence - 10...maxCadence) : (minCadence...minCadence + 1)
    }
    
    func setElevationChart() {
        elevationChartRange = (minAltitude < maxAltitude) ? (minAltitude - 10...maxAltitude) : (minAltitude...minAltitude + 1.0)
    }
    
    func calculateHeartRateZones() async {
        do {
            let currentUser = try await getUserUseCase.currentUser()
            self.heartRateZonesInfo = session.heartRateZonesInfo(user: currentUser)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func setHeartRateChart() {
        let minVal = Double(session.minHeartRate ?? 40)
        let maxVal = Double(session.maxHeartRate ?? 240)
        
        let lower = max(0.0, minVal)
        let upper = maxVal + 20.0
        hrChartRange = (lower < upper) ? (lower...upper) : (lower...lower + 1.0)
    }
}

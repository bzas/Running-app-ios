//
//  WorkoutSessionDataModel.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import Foundation
import SwiftData
import Domain

@Model
public final class WorkoutSessionDataModel: Identifiable {
    
    public var id: UUID
    public var timestamp: Date?
    public var heartRate: Int?
    public var maxHeartRate: Int?
    public var minHeartRate: Int?
    public var cadence: Int?
    public var speed: Double?
    public var distance: Double?
    public var totalTime: Double?
    public var latitude: Double?
    public var longitude: Double?
    public var sessionTrackPoints: [WorkoutSessionTrackPointDataModel]
    @Attribute(.externalStorage) public var photos: [SessionPhotoDataModel]
    public var verticalOscillation: Double?
    public var groundContactTime: Int?
    
    public init(
        id: UUID,
        timestamp: Date?,
        heartRate: Int?,
        maxHeartRate: Int?,
        minHeartRate: Int?,
        cadence: Int?,
        speed: Double?,
        distance: Double?,
        totalTime: Double?,
        latitude: Double?,
        longitude: Double?,
        sessionTrackPoints: [WorkoutSessionTrackPointDataModel],
        photos: [SessionPhotoDataModel],
        verticalOscillation: Double?,
        groundContactTime: Int?
    ) {
        self.id = id
        self.timestamp = timestamp
        self.heartRate = heartRate
        self.maxHeartRate = maxHeartRate
        self.minHeartRate = minHeartRate
        self.cadence = cadence
        self.speed = speed
        self.distance = distance
        self.totalTime = totalTime
        self.latitude = latitude
        self.longitude = longitude
        self.sessionTrackPoints = sessionTrackPoints
        self.photos = photos
        self.verticalOscillation = verticalOscillation
        self.groundContactTime = groundContactTime
    }
    
    convenience init(from domain: WorkoutSession) throws {
        self.init(
            id: domain.id,
            timestamp: domain.timestamp,
            heartRate: domain.heartRate,
            maxHeartRate: domain.maxHeartRate,
            minHeartRate: domain.minHeartRate,
            cadence: domain.cadence,
            speed: domain.speed,
            distance: domain.distance,
            totalTime: domain.totalTime,
            latitude: domain.latitude,
            longitude: domain.longitude,
            sessionTrackPoints: domain.sessionTrackPoints.compactMap {
                try? WorkoutSessionTrackPointDataModel(from: $0)
            },
            photos: domain.photos.map { SessionPhotoDataModel(from: $0) },
            verticalOscillation: domain.verticalOscillation,
            groundContactTime: domain.groundContactTime
        )
    }
}

// MARK: - Convert to Domain object

public extension WorkoutSessionDataModel {
    
    func toDomain() throws -> WorkoutSession {
        let sortedTrackPoints = sessionTrackPoints.sorted { $0.timestamp < $1.timestamp }
        
        return WorkoutSession(
            id: id,
            timestamp: timestamp,
            heartRate: heartRate,
            maxHeartRate: maxHeartRate,
            minHeartRate: minHeartRate,
            cadence: cadence,
            speed: speed ?? 0,
            distance: distance ?? 0,
            totalTime: totalTime ?? 0,
            latitude: latitude,
            longitude: longitude,
            sessionTrackPoints: try sortedTrackPoints.map {
                try $0.toDomain()
            },
            photos: photos.map { $0.toDomain() },
            verticalOscillation: verticalOscillation,
            groundContactTime: groundContactTime
        )
    }
}

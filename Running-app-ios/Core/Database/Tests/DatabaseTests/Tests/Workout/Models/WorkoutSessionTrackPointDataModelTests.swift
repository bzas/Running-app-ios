//
//  Untitled.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Foundation
import Domain
import TestSupport
@testable import Database

struct WorkoutSessionTrackPointDataModelTests {

    @Test func testConvertToDomain() throws {
        let timestamp = Date()
        let model = WorkoutSessionTrackPointDataModel(
            id: UUID(),
            latitude: 40.4168,
            longitude: -3.7038,
            altitude: 650,
            distance: 1000,
            heartRate: 150,
            timestamp: timestamp,
            cadence: 170
        )

        let domainModel = try model.toDomain()

        #expect(domainModel.id == model.id)
        #expect(domainModel.locationPoint.latitude == model.latitude)
        #expect(domainModel.locationPoint.longitude == model.longitude)
        #expect(domainModel.altitude == model.altitude)
        #expect(domainModel.distance == model.distance)
        #expect(domainModel.heartRate == model.heartRate)
        #expect(domainModel.timestamp == model.timestamp)
        #expect(domainModel.cadence == model.cadence)
    }

    @Test func testInstantiateFromDomainObject() throws {
        let domainObject = WorkoutSessionTrackPoint.mock
        let model = try WorkoutSessionTrackPointDataModel(from: domainObject)
        
        #expect(model.id == domainObject.id)
        #expect(model.latitude == domainObject.locationPoint.latitude)
        #expect(model.longitude == domainObject.locationPoint.longitude)
        #expect(model.altitude == domainObject.altitude)
        #expect(model.distance == domainObject.distance)
        #expect(model.heartRate == domainObject.heartRate)
        #expect(model.timestamp == domainObject.timestamp)
        #expect(model.cadence == domainObject.cadence)
    }
}

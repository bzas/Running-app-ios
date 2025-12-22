//
//  WorkoutSessionDataModelTests.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Foundation
import Domain
import TestSupport
@testable import Database

struct WorkoutSessionDataModelTests {

    @Test func testConvertToDomain() throws {
        let model = WorkoutSessionDataModel.mock
        let domainModel = try model.toDomain()

        #expect(domainModel.id == model.id)
        #expect(domainModel.distance == model.distance)
        #expect(domainModel.totalTime == model.totalTime)
        #expect(domainModel.photos.count == model.photos.count)
        #expect(domainModel.sessionTrackPoints.count == model.sessionTrackPoints.count)
    }

    @Test func testInstantiateFromDomainObject() throws {
        let domainObject = WorkoutSession.mock
        let model = try WorkoutSessionDataModel(from: domainObject)
        
        #expect(model.id == domainObject.id)
        #expect(model.distance == domainObject.distance)
        #expect(model.totalTime == domainObject.totalTime)
        #expect(model.photos.count == domainObject.photos.count)
        #expect(model.sessionTrackPoints.count == domainObject.sessionTrackPoints.count)
        #expect(model.maxHeartRate == domainObject.maxHeartRate)
        #expect(model.minHeartRate == domainObject.minHeartRate)
    }
}

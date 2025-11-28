//
//  UserDataModelTests.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Domain
@testable import Database

struct UserDataModelTests {

    @Test func testConvertToDomain() {
        let model = UserDataModel.mock
        let domainModel = model.toDomain()

        #expect(domainModel.name == model.name)
        #expect(domainModel.age == model.age)
        #expect(domainModel.maxHeartRate == model.maxHeartRate)
    }

    @Test func testInstantiateFromDomainObject() {
        let domainObject = User.mock
        let model = UserDataModel(from: domainObject)

        #expect(model.name == domainObject.name)
        #expect(model.age == domainObject.age)
        #expect(model.maxHeartRate == domainObject.maxHeartRate)
    }
}

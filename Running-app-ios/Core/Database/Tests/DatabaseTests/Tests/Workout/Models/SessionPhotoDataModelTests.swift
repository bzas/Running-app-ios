//
//  SessionPhotoDataModelTests.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Testing
import Foundation
import TestSupport
import Domain
@testable import Database

struct SessionPhotoDataModelTests {

    @Test func testConvertToDomain() throws {
        let model = SessionPhotoDataModel(
            id: UUID(),
            data: Data("photo".utf8)
        )

        let domainModel = model.toDomain()

        #expect(domainModel.id == model.id)
        #expect(domainModel.data == model.data)
    }

    @Test func testInstantiateFromDomainObject() {
        let domainObject = SessionPhoto.mock
        let model = SessionPhotoDataModel(from: domainObject)

        #expect(domainObject.id == model.id)
        #expect(domainObject.data == model.data)
    }
}

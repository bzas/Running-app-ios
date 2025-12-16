//
//  RequestHealthAccessUseCaseTests.swift
//  Application
//
//  Created by Alfonso Boizas Crespo on 16/12/25.
//

import Testing
import TestSupport
@testable import Application

struct RequestHealthAccessUseCaseTests {

    @Test func testRequestUserPermission() async throws {
        let healthKitService = HealthKitServiceMock()
        let useCase = RequestHealthAccessUseCase(healthKitService: healthKitService)

        try await useCase.requestUserPermission()

        let callCount = await healthKitService.requestUserPermissionCallCount
        #expect(callCount == 1)
    }

    @Test func testRequestUserPermissionFailure() async throws {
        let healthKitService = HealthKitServiceMock()
        let useCase = RequestHealthAccessUseCase(healthKitService: healthKitService)
        await healthKitService.setError(MockError.sample)

        await #expect(throws: Error.self) {
            try await useCase.requestUserPermission()
        }

        let callCount = await healthKitService.requestUserPermissionCallCount
        #expect(callCount == 1)
    }
}

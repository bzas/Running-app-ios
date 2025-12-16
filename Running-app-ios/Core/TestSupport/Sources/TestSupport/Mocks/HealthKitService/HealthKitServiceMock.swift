//
//  HealthKitServiceMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 16/12/25.
//

import HealthKitService

public actor HealthKitServiceMock: HealthKitServiceProtocol {

    public var requestUserPermissionCallCount = 0
    public var errorToThrow: Error?
    
    public init(
        requestUserPermissionCallCount: Int = 0,
        errorToThrow: Error? = nil
    ) {
        self.requestUserPermissionCallCount = requestUserPermissionCallCount
        self.errorToThrow = errorToThrow
    }

    public func setError(_ error: Error?) {
        errorToThrow = error
    }

    public func requestUserPermission() async throws {
        requestUserPermissionCallCount += 1

        if let errorToThrow {
            throw errorToThrow
        }
    }
}

//
//  RequestHealthAccessUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 16/12/25.
//

import Application

public actor RequestHealthAccessUseCaseMock: RequestHealthAccessUseCaseProtocol {

    // MARK: - Tracking

    public private(set) var requestUserPermissionCallCount = 0

    // MARK: - Stubbing

    public var errorToThrow: Error?
    
    public init() {}
    
    public func requestUserPermission() async throws {
        requestUserPermissionCallCount += 1
        
        if let errorToThrow {
            throw errorToThrow
        }
    }
    
}

//
//  GetGalleryUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Domain
import Application

public actor GetGalleryUseCaseMock {
    
    // MARK: - Tracking
    public private(set) var getAllPhotosCallCount = 0
    
    // MARK: - Stubbing
    public var photosResult: [SessionPhoto] = []
    public var errorToThrow: Error?
    
    public init() {}
    
    public func getAllPhotos() async throws -> [SessionPhoto] {
        getAllPhotosCallCount += 1
        
        if let errorToThrow {
            throw errorToThrow
        }
        
        return photosResult
    }
}

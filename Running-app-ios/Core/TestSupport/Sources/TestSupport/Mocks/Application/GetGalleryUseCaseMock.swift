//
//  GetGalleryUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Domain
import Application

public actor GetGalleryUseCaseMock: GetGalleryUseCaseProtocol {
    
    // MARK: - Tracking
    
    public private(set) var getAllPhotosCallCount = 0
    public let repository: WorkoutRepositoryProtocol
    
    // MARK: - Stubbing
    
    public private(set) var photosResult: [SessionPhoto] = []
    public private(set) var errorToThrow: Error?
    
    public init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }

    public func setPhotosResult(_ photos: [SessionPhoto]) {
        photosResult = photos
    }
    
    public func setErrorToThrow(_ error: Error?) {
        errorToThrow = error
    }
    
    public func getAllPhotos() async throws -> [SessionPhoto] {
        getAllPhotosCallCount += 1
        
        if let errorToThrow {
            throw errorToThrow
        }
        
        return photosResult
    }
}

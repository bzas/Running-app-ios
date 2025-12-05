//
//  UpdateGalleryUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Domain
import Application

public actor UpdateGalleryUseCaseMock: UpdateGalleryUseCaseProtocol {
    
    // MARK: - Tracking
    
    public private(set) var updatePhotosCallCount = 0
    public private(set) var deletePhotoCallCount = 0
    public private(set) var updatedSessions: [WorkoutSession] = []
    public private(set) var deletedPhotos: [SessionPhoto] = []
    public let repository: WorkoutRepositoryProtocol
    
    // MARK: - Stubbing
    
    public var updateErrorToThrow: Error?
    public var deleteErrorToThrow: Error?
    
    public init(repository: WorkoutRepositoryProtocol) {
        self.repository = repository
    }
    
    public func updatePhotos(_ model: WorkoutSession) async throws {
        updatePhotosCallCount += 1
        updatedSessions.append(model)
        
        if let updateErrorToThrow {
            throw updateErrorToThrow
        }
    }
    
    public func deletePhoto(_ photo: SessionPhoto) async throws {
        deletePhotoCallCount += 1
        deletedPhotos.append(photo)
        
        if let deleteErrorToThrow {
            throw deleteErrorToThrow
        }
    }
}

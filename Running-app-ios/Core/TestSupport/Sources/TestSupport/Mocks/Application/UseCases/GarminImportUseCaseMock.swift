//
//  GarminImportUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Application
import Domain
import GarminKit

public actor GarminImportUseCaseMock: GarminImportUseCaseProtocol {
    
    // MARK: - Tracking
    
    public private(set) var importCallCount = 0
    public private(set) var importedFiles: [URL] = []
    public private(set) var lastImportedFile: URL?
    public let garminService: GarminServiceProtocol
    public let repository: WorkoutRepositoryProtocol
    
    // MARK: - Stubbing
    
    public var errorToThrow: Error?
    
    public init(
        garminService: GarminServiceProtocol,
        repository: WorkoutRepositoryProtocol
    ) {
        self.garminService = garminService
        self.repository = repository
    }
    
    public func importSession(from file: URL) async throws {
        importCallCount += 1
        importedFiles.append(file)
        lastImportedFile = file
        
        if let errorToThrow {
            throw errorToThrow
        }
    }
}

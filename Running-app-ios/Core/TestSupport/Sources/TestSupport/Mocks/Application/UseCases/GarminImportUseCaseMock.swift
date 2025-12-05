//
//  GarminImportUseCaseMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 5/12/25.
//

import Foundation
import Application

public actor GarminImportUseCaseMock {
    
    // MARK: - Tracking
    public private(set) var importCallCount = 0
    public private(set) var importedFiles: [URL] = []
    public private(set) var lastImportedFile: URL?
    
    // MARK: - Stubbing
    public var errorToThrow: Error?
    
    public init() {}
    
    public func importSession(from file: URL) async throws {
        importCallCount += 1
        importedFiles.append(file)
        lastImportedFile = file
        
        if let errorToThrow {
            throw errorToThrow
        }
    }
}

//
//  GarminServiceMock.swift
//  TestSupport
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import GarminKit
import Domain
import Foundation

public actor GarminServiceMock: GarminServiceProtocol {
    
    public private(set) var lastData: Data?
    private var result: WorkoutSession?
    private var error: Error?

    public init() {}

    public func fetchFitFile(from data: Data) async throws -> WorkoutSession {
        lastData = data
        if let error { throw error }
        guard let result else {
            throw MockError.noResult
        }
        return result
    }

    public func setResult(_ session: WorkoutSession?) {
        result = session
    }

    public func setError(_ error: Error?) {
        self.error = error
    }
}

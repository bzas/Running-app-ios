//
//  HealthKitError.swift
//  HealthKitService
//
//  Created by Alfonso Boizas Crespo on 20/12/25.
//

import Foundation

public enum HealthKitError: LocalizedError {
    case noHealthDataAvailable
    
    public var errorDescription: String? {
        switch self {
        case .noHealthDataAvailable:
            "No Apple Health data available"
        }
    }
}

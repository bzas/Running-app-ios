//
//  GarminServiceProtocol.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation
import Domain

public protocol GarminServiceProtocol: Sendable {
    
    func fetchFitFile(from data: Data) async throws -> WorkoutSession
}

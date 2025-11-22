//
//  GarminService.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Foundation
import FITSwiftSDK
import Domain

public struct GarminService: GarminServiceProtocol {
    
    public init() {}
    
    public func fetchFitFile(from data: Data) async throws -> WorkoutSession {
        let stream = FITSwiftSDK.InputStream(data: data)
        let decoder = Decoder(stream: stream)
        let garminListener = FitListener()
        decoder.addMesgListener(garminListener)
        try decoder.read()

        let garminSession = try GarminWorkoutSessionDTO(listener: garminListener)
        return garminSession.toDomain()
    }
}

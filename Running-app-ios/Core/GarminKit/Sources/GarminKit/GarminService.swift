//
//  GarminService.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 14/11/25.
//

import Database
import Foundation
import FITSwiftSDK

public actor GarminService: GarminServiceProtocol {
    
    public init() {}
    
    public func fetchFitFile(from data: Data) async throws -> WorkoutSessionDataModel? {
        let stream = FITSwiftSDK.InputStream(data: data)
        let decoder = Decoder(stream: stream)
        let garminListener = FitListener()
        decoder.addMesgListener(garminListener)
        try decoder.read();

        return WorkoutSessionDataModel(listener: garminListener)
    }
}

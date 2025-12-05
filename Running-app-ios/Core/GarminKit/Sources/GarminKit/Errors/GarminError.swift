//
//  GarminError.swift
//  GarminKit
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import Foundation

public enum GarminError: LocalizedError {
    case missingSessionMessageError,
         trackPointLocalizationError,
         wrongSportDataError
    
    public var errorDescription: String? {
        switch self {
        case .wrongSportDataError:
            "Sorry, the sport uploaded is not supported"
        default:
            "Sorry, an error occurred processing the .fit file"
        }
    }
}

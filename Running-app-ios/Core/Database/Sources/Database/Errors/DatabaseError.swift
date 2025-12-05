//
//  DatabaseError.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import Foundation

enum DatabaseError: LocalizedError {
    case trackPointDataError,
         noUserData,
         sessionNotFound
    
    var errorDescription: String? {
        switch self {
        case .trackPointDataError:
            "An error occured processing your workout"
        case .noUserData:
            "No user data found"
        case .sessionNotFound:
            "An error occured fetching your workouts"
        }
    }
}

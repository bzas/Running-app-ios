//
//  DayCellDistanceType.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI

enum DayCellDistanceType {
    
    case none,
         short,
         medium,
         long
    
    var color: Color {
        switch self {
        case .none:
                .white.opacity(0.15)
        case .short:
            Color(
                red: 110/255.0,
                green: 160/255.0,
                blue: 200/255.0
            )
        case .medium:
            Color(
                red: 40/255.0,
                green: 110/255.0,
                blue: 180/255.0
            )
        case .long:
            Color(
                red: 12/255.0,
                green: 55/255.0,
                blue: 120/255.0
            )
        }
    }
    
    static func initFromKm(_ kms: Double?) -> DayCellDistanceType {
        guard let kms,
              kms > 0 else { return .none }
        
        switch kms {
        case ..<5:
            return .short
        case 5..<10:
            return .medium
        default:
            return .long
        }
    }
}

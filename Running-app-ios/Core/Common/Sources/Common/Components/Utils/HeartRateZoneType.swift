//
//  HeartRateZoneType.swift
//  Common
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//

import SwiftUI

public enum HeartRateZoneType: CaseIterable {
    
    case zone1,
         zone2,
         zone3,
         zone4,
         zone5
    
    public var title: String {
        switch self {
        case .zone1:
            "Zone 1"
        case .zone2:
            "Zone 2"
        case .zone3:
            "Zone 3"
        case .zone4:
            "Zone 4"
        case .zone5:
            "Zone 5"
        }
    }
    
    public var color: Color {
        switch self {
        case .zone1:
                .blue
        case .zone2:
                .cyan
        case .zone3:
                .green
        case .zone4:
                .orange
        case .zone5:
                .red
        }
    }
    
    public var profileColor: Color {
        switch self {
        case .zone1:
            Color(
                red: 236/255.0,
                green: 112/255.0,
                blue: 99/255.0
            )
        case .zone2:
            Color(
                red: 231/255.0,
                green: 76/255.0,
                blue: 60/255.0
                
            )
        case .zone3:
            Color(
                red: 203/255.0,
                green: 67/255.0,
                blue: 53/255.0
            )
        case .zone4:
            Color(
                red: 146/255.0,
                green: 43/255.0,
                blue: 33/255.0
            )
        case .zone5:
            Color(
                red: 110/255.0,
                green: 31/255.0,
                blue: 24/255.0,
            )
        }
    }
    
    public static func fromZoneNumber(_ number: Int) -> Self {
        let index = number - 1
        guard index >= 0, index < Self.allCases.count else {
            return .zone1
        }
        
        return Self.allCases[number - 1]
    }
}

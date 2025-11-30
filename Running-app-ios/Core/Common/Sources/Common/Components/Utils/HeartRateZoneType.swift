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
                red: 110/255.0,
                green: 160/255.0,
                blue: 200/255.0
            )
        case .zone2:
            Color(
                red: 70/255.0,
                green: 135/255.0,
                blue: 200/255.0
                
            )
        case .zone3:
            Color(
                red: 40/255.0,
                green: 110/255.0,
                blue: 180/255.0
            )
        case .zone4:
            Color(
                red: 25/255.0,
                green: 90/255.0,
                blue: 160/255.0
            )
        case .zone5:
            Color(
                red: 12/255.0,
                green: 55/255.0,
                blue: 120/255.0
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

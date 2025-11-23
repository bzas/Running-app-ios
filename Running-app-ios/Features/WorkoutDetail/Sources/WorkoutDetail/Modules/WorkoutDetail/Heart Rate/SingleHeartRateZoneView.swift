//
//  SingleHeartRateZoneView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI

enum HeartRateZoneType {
    case zone1,
         zone2,
         zone3,
         zone4,
         zone5
    
    var title: String {
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
    
    var color: Color {
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
}

struct SingleHeartRateZoneView: View {
    
    var zoneNumber: HeartRateZoneType
    
    var body: some View {
        HStack(spacing: 16) {
            Text(zoneNumber.title)
                .font(.callout)
                .bold()
                .foregroundStyle(zoneNumber.color)
            
            ZStack {
                Capsule()
                    .frame(maxWidth: .infinity)
                    .foregroundColor(zoneNumber.color.opacity(0.25))

                HStack {
                    Capsule()
                        .frame(width: 100)
                        .foregroundColor(zoneNumber.color)
                    Spacer()
                }
            }
            .frame(height: 8)
            
            Text("125-130 bpm")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

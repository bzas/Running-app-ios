//
//  SingleHeartRateZoneView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Domain

enum HeartRateZoneType: CaseIterable {
    
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
    
    static func fromZoneNumber(_ number: Int) -> Self {
        let index = number - 1
        guard index >= 0, index < Self.allCases.count else {
            return .zone1
        }
        
        return Self.allCases[number - 1]
    }
}

struct SingleHeartRateZoneView: View {
    
    var zoneNumber: HeartRateZoneType
    var zoneInfo: SessionHeartRateZone
    
    init(zoneInfo: SessionHeartRateZone) {
        self.zoneNumber = HeartRateZoneType.fromZoneNumber(zoneInfo.zoneNumber)
        self.zoneInfo = zoneInfo
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Text(zoneNumber.title)
                .font(.callout)
                .bold()
                .foregroundStyle(zoneNumber.color)
            
            HStack(spacing: 4) {
                GeometryReader { reader in
                    ZStack {
                        Capsule()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(zoneNumber.color.opacity(0.25))

                        HStack {
                            Capsule()
                                .frame(width: reader.size.width * zoneInfo.percentageInZone)
                                .foregroundColor(zoneNumber.color)
                            Spacer()
                        }
                    }
                }
                .frame(height: 8)
                
                zoneRangeText()
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .frame(width: 90)
            }
        }
    }
    
    @ViewBuilder
    func zoneRangeText() -> some View {
        HStack {
            Spacer()
            
            if let lowerLimit = zoneInfo.lowerLimit,
               let upperLimit = zoneInfo.upperLimit {
                Text("\(lowerLimit)-\(upperLimit) bpm")
            } else if let lowerLimit = zoneInfo.lowerLimit {
                Text("\(lowerLimit)+ bpm")
            } else if let upperLimit = zoneInfo.upperLimit {
                Text("<\(upperLimit) bpm")
            } else {
                EmptyView()
            }
        }
    }
}

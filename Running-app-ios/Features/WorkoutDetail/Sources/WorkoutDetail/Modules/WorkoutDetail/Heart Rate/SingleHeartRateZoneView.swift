//
//  SingleHeartRateZoneView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Domain
import Common

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
                .fontWeight(.semibold)
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
                
                Text(
                    DataFormatter.heartRateRange(
                        minHeartRate: zoneInfo.lowerLimit,
                        maxHeartRate: zoneInfo.upperLimit
                    )
                )
                .font(.footnote)
                .foregroundStyle(.secondary)
                .frame(width: 90)
            }
        }
    }
}

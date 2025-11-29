//
//  HeartRateZoneInfoView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//

import SwiftUI
import Common
import Domain

struct HeartRateZoneInfoView: View {
    
    var zoneNumber: HeartRateZoneType
    var zoneInfo: HeartRateZone
    
    init(zoneInfo: HeartRateZone) {
        self.zoneNumber = HeartRateZoneType.fromZoneNumber(zoneInfo.zoneNumber)
        self.zoneInfo = zoneInfo
    }
    
    var body: some View {
        HStack {
            Text(zoneNumber.title)
            Spacer()
            Text(
                DataFormatter.heartRateRange(
                    minHeartRate: zoneInfo.minHeartRate,
                    maxHeartRate: zoneInfo.maxHeartRate
                )
            )
            .foregroundStyle(.secondary)
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(zoneNumber.profileColor)
    }
}

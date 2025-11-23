//
//  HeartRateZonesView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import SwiftUI

struct HeartRateZonesView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel

    var body: some View {
        VStack(spacing: 16) {
            SingleHeartRateZoneView(zoneNumber: .zone1)
            SingleHeartRateZoneView(zoneNumber: .zone2)
            SingleHeartRateZoneView(zoneNumber: .zone3)
            SingleHeartRateZoneView(zoneNumber: .zone4)
            SingleHeartRateZoneView(zoneNumber: .zone5)
        }
    }
}

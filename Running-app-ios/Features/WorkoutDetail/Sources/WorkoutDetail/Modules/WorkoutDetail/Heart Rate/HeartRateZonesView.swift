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
            ForEach(viewModel.heartRateZonesInfo) { info in
                SingleHeartRateZoneView(zoneInfo: info)
            }
        }
    }
}

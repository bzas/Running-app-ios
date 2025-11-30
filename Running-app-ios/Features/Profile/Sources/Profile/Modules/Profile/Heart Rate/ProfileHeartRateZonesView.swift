//
//  ProfileHeartRateZonesView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//

import SwiftUI
import Common

struct ProfileHeartRateZonesView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Heart Rate Zones")
                .font(.title3)
                .fontWeight(.semibold)
            
            VStack {
                HStack {
                    Text("Maximum heart rate")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(DataFormatter.heartRate(viewModel.userInfo?.maxHeartRate))
                        .fontWeight(.semibold)
                }
                
                ForEach(viewModel.userInfo?.heartRateZones ?? []) {
                    HeartRateZoneInfoView(zoneInfo: $0)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProfileHeartRateZonesView()
}

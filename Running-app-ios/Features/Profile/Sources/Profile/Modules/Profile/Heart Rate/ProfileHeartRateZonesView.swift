//
//  ProfileHeartRateZonesView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//

import SwiftUI
import Common
import Localization

struct ProfileHeartRateZonesView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(Localizables.Profile.heartRateZonesTitle)
                .font(.title3)
                .fontWeight(.semibold)
            
            VStack {
                HStack {
                    Text(Localizables.Common.maximumHeartRate)
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

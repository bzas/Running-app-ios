//
//  ProfileHeaderView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//

import SwiftUI
import Common

struct ProfileHeaderView: View {

    @EnvironmentObject var viewModel: ProfileViewModel

    var body: some View {
        HStack {
            if let userInfo = viewModel.userInfo {
                Text(userInfo.name)
                    .font(.title)
                
                Text(DataFormatter.age(userInfo.age))
                    .font(.title)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

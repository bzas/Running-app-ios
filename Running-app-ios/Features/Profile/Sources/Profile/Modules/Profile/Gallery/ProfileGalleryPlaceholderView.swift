//
//  ProfileGalleryPlaceholderView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI

struct ProfileGalleryPlaceholderView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "camera")
                .resizable()
                .scaledToFit()
                .frame(
                    width: 30,
                    height: 30
                )
            Text("No photos added yet")
        }
        .foregroundStyle(.tertiary)
        .frame(maxWidth: .infinity)
        .padding()
    }
}

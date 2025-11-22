//
//  WorkoutsPlaceholderView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import SwiftUI

public struct WorkoutsPlaceholderView: View {
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "figure.run.square.stack")
                .font(.system(size: 60))
                .foregroundStyle(.secondary)

            VStack(spacing: 8) {
                Text("No workouts yet")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.secondary)

                Text("Import a .fit file to start")
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(32)
    }
}

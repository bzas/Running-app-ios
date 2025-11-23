//
//  WorkoutsPlaceholderView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import SwiftUI

public struct WorkoutsPlaceholderView: View {
    
    @State private var rotate = false
    var isLoading: Bool

    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
    
    public var body: some View {
        if isLoading {
            Circle()
                .trim(from: 0.2, to: 1)
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .foregroundStyle(.secondary)
                .onAppear {
                    withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                        rotate = true
                    }
                }
        } else {
            VStack(spacing: 16) {
                Image(systemName: "figure.run.square.stack")
                    .font(.system(size: 60))
                    .fontWeight(.light)

                VStack(spacing: 8) {
                    Text("No workouts yet")
                        .font(.title2)
                        .bold()

                    Text("Import a .fit file to start")
                        .font(.caption)
                }
            }
            .foregroundStyle(.secondary)
            .padding(32)
        }
    }
}

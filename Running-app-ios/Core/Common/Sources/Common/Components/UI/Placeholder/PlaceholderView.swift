//
//  WorkoutsPlaceholderView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 22/11/25.
//

import SwiftUI
import Localization

public struct PlaceholderView: View {
    
    @State private var rotate = false
    private var isLoading: Bool
    private var type: PlaceholderType

    public init(
        isLoading: Bool = false,
        type: PlaceholderType
    ) {
        self.isLoading = isLoading
        self.type = type
    }
    
    public var body: some View {
        if isLoading {
            Circle()
                .trim(from: 0.2, to: 1)
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(rotate ? 360 : 0))
                .foregroundStyle(.secondary)
                .accessibilityLabel(Localizables.Accessibility.loading)
                .onAppear {
                    withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
                        rotate = true
                    }
                }
        } else {
            VStack(spacing: 16) {
                Image(systemName: type.iconName)
                    .font(.system(size: type.iconSize))
                    .fontWeight(.light)

                VStack(spacing: 8) {
                    Text(type.title)
                        .font(.title3)
                        .fontWeight(.semibold)

                    Text(type.subtitle)
                        .font(.caption)
                }
            }
            .foregroundStyle(.secondary)
            .padding(32)
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(type.title). \(type.subtitle)")
        }
    }
}

//
//  DayInfoView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI
import Common

struct DayInfoView: View {

    let name: String
    let date: String
    let distance: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(name)
                .font(.footnote)
                .fontWeight(.semibold)
            
            HStack {
                Text(date)
                    .font(.caption2)
                
                Text(distance)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(8)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .shadow(radius: 6)
    }
}

struct DayCellAnchorKey: PreferenceKey {
    
    static let defaultValue: [Int: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [Int: Anchor<CGRect>], nextValue: () -> [Int: Anchor<CGRect>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

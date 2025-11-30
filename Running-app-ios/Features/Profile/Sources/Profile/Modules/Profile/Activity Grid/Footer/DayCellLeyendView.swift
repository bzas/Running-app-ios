//
//  DayCellLeyendView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI

struct DayCellLeyendView: View {
    
    let cellSize: CGFloat

    var body: some View {
        HStack(spacing: 4) {
            ForEach(Array(stride(from: 0, through: 12, by: 4)), id: \.self) { kms in
                DayCellView(
                    dayAndKms: DayAndKms(id: UUID(), day: 0, kms: Double(kms)),
                    cellSize: cellSize
                )
            }
            GridNoteLabel(text: "+ Kms")
        }
    }
}

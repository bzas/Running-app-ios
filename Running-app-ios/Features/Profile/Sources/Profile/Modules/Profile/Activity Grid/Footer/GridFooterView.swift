//
//  GridFooterView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI

struct GridFooterView: View {
    
    let cellSize: CGFloat

    var body: some View {
        HStack {
            DayCellLeyendView(cellSize: cellSize)
            Spacer()
            GridNoteLabel(text: "Last year's activity")
        }
        .padding(.horizontal)
        .padding(.top, 2)
    }
}

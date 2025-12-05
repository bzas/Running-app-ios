//
//  GridFooterView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI
import Localization

struct GridFooterView: View {
    
    let cellSize: CGFloat

    var body: some View {
        HStack {
            DayCellLeyendView(cellSize: cellSize)
            Spacer()
            GridNoteLabel(text: Localizables.Profile.activityGridFooter)
        }
        .padding(.horizontal)
        .padding(.top, 2)
    }
}

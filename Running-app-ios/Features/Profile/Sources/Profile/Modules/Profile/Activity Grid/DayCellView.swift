//
//  DayCellView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI

struct DayCellView: View {
    
    let dayAndKms: DayAndKms?
    let cellSize: CGFloat
    private let cellDistanceType: DayCellDistanceType
    
    init(dayAndKms: DayAndKms?, cellSize: CGFloat) {
        self.dayAndKms = dayAndKms
        self.cellSize = cellSize
        cellDistanceType = DayCellDistanceType.initFromKm(dayAndKms?.kms)
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(cellDistanceType.color)
            .frame(
                width: cellSize,
                height: cellSize
            )
            .contentShape(Rectangle())
    }
}

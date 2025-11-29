//
//  ActivityGridView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//

import SwiftUI

struct ActivityGridView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel

    private let cellSize: CGFloat = 16
    private let totalDays = 365
    
    private var rows: [GridItem] {
        Array(repeating: GridItem(.fixed(cellSize), spacing: 4), count: 7)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 4) {
                ForEach(0..<totalDays, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(.white.opacity(0.2))
                        .frame(width: cellSize, height: cellSize)
                }
            }
            .padding(.vertical, 4)
        }
    }
}

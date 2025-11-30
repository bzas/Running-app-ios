//
//  ActivityGridView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//

import SwiftUI
import Common

struct ActivityGridView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel
    
    private let cellSize: CGFloat = 16
    private let totalDays: Int = Date.isLeapYear ? 366 : 365
    
    private var rows: [GridItem] {
        Array(
            repeating: GridItem(.fixed(cellSize), spacing: 4),
            count: 7
        )
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 6) {
            ScrollView(.horizontal, showsIndicators: false) {
                VStack(spacing: 6) {
                    GridHeaderView()

                    LazyHGrid(rows: rows, spacing: 4) {
                        ForEach(0..<totalDays, id: \.self) { index in
                            DayCellView(
                                dayAndKms: viewModel.sessionDaysAndKmsOfYear.first(where: { $0.day == index + 1}),
                                cellSize: cellSize
                            )
                            .onTapGesture {
                                viewModel.tapOnDay(index: index)
                            }
                            .anchorPreference(key: DayCellAnchorKey.self, value: .bounds) { [index: $0] }
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            GridFooterView(cellSize: cellSize)
        }
        .padding(.bottom)
    }
}

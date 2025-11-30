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

// MARK: - Private methods

private extension ActivityGridView {
    
    func daysIn(
        monthIndex: Int,
        year: Int = Calendar.current.component(.year, from: Date())
    ) -> Int {
        let components = DateComponents(
            year: year,
            month: monthIndex + 1
        )
        let calendar = Calendar.current
        
        let date = calendar.date(from: components)!
        return calendar.range(
            of: .day,
            in: .month,
            for: date
        )!.count
    }
}

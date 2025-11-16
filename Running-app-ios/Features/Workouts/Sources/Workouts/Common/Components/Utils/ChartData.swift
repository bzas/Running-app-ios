//
//  ChartData.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import Foundation

struct ChartData: Identifiable, Equatable {
    let id = UUID()
    let label: String
    let value: Double
}

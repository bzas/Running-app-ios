//
//  ChartData.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 17/11/25.
//

import Foundation

public struct ChartData: Identifiable, Equatable {
    
    public let id = UUID()
    public let label: String
    public let value: Double
    
    public init(
        label: String,
        value: Double
    ) {
        self.label = label
        self.value = value
    }
}

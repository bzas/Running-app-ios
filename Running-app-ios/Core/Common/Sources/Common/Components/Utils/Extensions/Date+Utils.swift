//
//  Date+Utils.swift
//  Common
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import Foundation

public extension Date {
    
    var dayOfYear: Int {
        Calendar.current.ordinality(
            of: .day,
            in: .year,
            for: self
        ) ?? 0
    }
    
    static var isLeapYear: Bool {
        let year = Calendar.current.component(.year, from: Date())
        return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
    }
}

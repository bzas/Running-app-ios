//
//  String+Localizables.swift
//  Localization
//
//  Created by Alfonso Boizas Crespo on 9/11/25.
//

import Foundation

extension String {
    
    var localized: String {
        String(
            localized: LocalizationValue(self),
            bundle: .module
        )
    }
}

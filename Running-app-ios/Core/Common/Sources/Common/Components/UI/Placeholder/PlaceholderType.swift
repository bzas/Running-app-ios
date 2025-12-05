//
//  PlaceholderType.swift
//  Common
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Localization

public enum PlaceholderType {
    case images,
         workouts
    
    var iconName: String {
        switch self {
        case .images:
            "photo.stack"
        case .workouts:
            "figure.run.square.stack"
        }
    }
    
    var title: String {
        switch self {
        case .images:
            Localizables.Common.Placeholder.Images.title
        case .workouts:
            Localizables.Common.Placeholder.Workouts.title
        }
    }
    
    var subtitle: String {
        switch self {
        case .images:
            Localizables.Common.Placeholder.Images.subtitle
        case .workouts:
            Localizables.Common.Placeholder.Workouts.subtitle
        }
    }
    
    var iconSize: CGFloat {
        switch self {
        case .images:
            40
        case .workouts:
            60
        }
    }
}

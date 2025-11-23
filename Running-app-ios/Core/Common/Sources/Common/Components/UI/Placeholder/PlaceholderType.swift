//
//  PlaceholderType.swift
//  Common
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI

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
            "No images yet"
        case .workouts:
            "No workouts yet"
        }
    }
    
    var subtitle: String {
        switch self {
        case .images:
            "Tap the plus button to add some"
        case .workouts:
            "Import a .fit file to start"
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

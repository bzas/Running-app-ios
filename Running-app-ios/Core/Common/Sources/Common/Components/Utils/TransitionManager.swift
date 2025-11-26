//
//  TransitionManager.swift
//  Common
//
//  Created by Alfonso Boizas Crespo on 21/11/25.
//

import Foundation

public final class TransitionManager {
    
    public static func detailInfoTransitionId(for id: UUID) -> String {
         "detailInfoTransition-\(id.uuidString)"
     }
    
    public static func detailHeartRateTransitionId(for id: UUID) -> String {
         "heartRateDetailTransition-\(id.uuidString)"
     }
    
    public static func galleryTransitionId(for id: UUID) -> String {
         "galleryTransition-\(id.uuidString)"
     }
    
    public static func metricsTransitionId(for id: UUID) -> String {
         "metricsTransition-\(id.uuidString)"
     }
    
    public static func detailTransitionId(for id: UUID) -> String {
         "detailTransition-\(id.uuidString)"
     }
    
    public static func detailImageTransitionId(for id: UUID) -> String {
        "detailImageTransitionId-\(id.uuidString)"
    }
}

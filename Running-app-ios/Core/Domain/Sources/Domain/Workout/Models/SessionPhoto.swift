//
//  SessionPhoto.swift
//  Domain
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Foundation

public struct SessionPhoto: Sendable, Identifiable {
    
    public let id: UUID
    public let data: Data
    
    public init(
        id: UUID = UUID(),
        data: Data
    ) {
        self.id = id
        self.data = data
    }
}

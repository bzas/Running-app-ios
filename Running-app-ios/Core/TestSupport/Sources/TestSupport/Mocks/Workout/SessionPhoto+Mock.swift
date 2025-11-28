//
//  SessionPhoto+Mock.swift
//  Domain
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Domain
import Foundation

public extension SessionPhoto {
    
    static var mock: SessionPhoto {
        SessionPhoto(
            data: Data("test-photo".utf8)
        )
    }
}

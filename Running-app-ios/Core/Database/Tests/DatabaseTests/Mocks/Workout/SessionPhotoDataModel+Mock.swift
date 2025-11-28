//
//  SessionPhotoDataModel+Mock.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

@testable import Database
import Foundation

extension SessionPhotoDataModel {
    
    static var mock: SessionPhotoDataModel {
        SessionPhotoDataModel(
            id: UUID(),
            data: Data("test-photo".utf8)
        )
    }
}

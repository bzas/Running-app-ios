//
//  SessionPhotoDataModel.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Foundation
import Domain
import SwiftData

@Model
public class SessionPhotoDataModel: Identifiable {
    
    public var id: UUID
    public var data: Data
    
    public init(
        id: UUID,
        data: Data
    ) {
        self.id = id
        self.data = data
    }
    
    public convenience init(from photo: SessionPhoto) {
        self.init(
            id: photo.id,
            data: photo.data
        )
    }
}

// MARK: - Convert to Domain object

extension SessionPhotoDataModel {
    
    func toDomain() -> SessionPhoto {
        SessionPhoto(
            id: id,
            data: data
        )
    }
}

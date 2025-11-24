//
//  UserDataModel.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain
import SwiftData
import Foundation

@Model
public class UserDataModel {
    
    public var name: String
    public var age: Int
    public var maxHeartRate: Int
    
    public init(
        name: String,
        age: Int,
        maxHeartRate: Int
    ) {
        self.name = name
        self.age = age
        self.maxHeartRate = maxHeartRate
    }
    
    convenience init(from domain: User) {
        self.init(
            name: domain.name,
            age: domain.age,
            maxHeartRate: domain.maxHeartRate
        )
    }
}

// MARK: - Convert to Domain object

extension UserDataModel {
    
    func toDomain() -> User {
        User(
            name: name,
            age: age,
            maxHeartRate: maxHeartRate
        )
    }
}

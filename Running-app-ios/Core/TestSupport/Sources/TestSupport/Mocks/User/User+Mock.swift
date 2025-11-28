//
//  User+Mock.swift
//  Domain
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import Domain

public extension User {
    
    static var mock: User {
        User(
            name: "John Doe",
            age: 33,
            maxHeartRate: 197
        )
    }
}

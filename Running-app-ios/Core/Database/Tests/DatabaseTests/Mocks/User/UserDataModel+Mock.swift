//
//  UserDataModel+Mock.swift
//  Database
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

@testable import Database

extension UserDataModel {
    
    static var mock: UserDataModel {
        UserDataModel(
            name: "John Doe",
            age: 33,
            maxHeartRate: 197
        )
    }
}

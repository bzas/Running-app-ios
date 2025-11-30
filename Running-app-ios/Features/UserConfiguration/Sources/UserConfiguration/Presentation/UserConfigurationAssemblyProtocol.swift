//
//  UserConfigurationAssemblyProtocol.swift
//  UserConfiguration
//
//  Created by Alfonso Boizas Crespo on 19/11/25.
//

import Domain

public protocol UserConfigurationAssemblyProtocol {
    
    func makeUserConfigurationViewModel(
        savedUser: User?,
        completion: (() -> Void)?
    ) -> UserConfigurationViewModel
}

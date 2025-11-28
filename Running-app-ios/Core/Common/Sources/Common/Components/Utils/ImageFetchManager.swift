//
//  ImageFechManager.swift
//  Common
//
//  Created by Alfonso Boizas Crespo on 28/11/25.
//

import UIKit

public struct ImageFetchManager {
    
    public static func fetchImage(from data: Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }
}

//
//  PhotoItem.swift
//  Common
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import UIKit

public struct PhotoItem: Identifiable {
    
    public let id = UUID()
    public let image: UIImage
    
    public init(image: UIImage) {
        self.image = image
    }
}

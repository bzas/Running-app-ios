//
//  GridNoteLabel.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI

struct GridNoteLabel: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .font(.footnote)
            .foregroundStyle(.secondary)
    }
}

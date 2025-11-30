//
//  SectionTitleView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI

struct SectionTitleView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.semibold)
    }
}

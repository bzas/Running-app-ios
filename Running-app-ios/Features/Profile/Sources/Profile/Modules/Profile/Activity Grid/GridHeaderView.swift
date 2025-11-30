//
//  GridHeaderView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI

struct GridHeaderView: View {
    
    private let months = [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ]
    
    var body: some View {
        HStack {
            ForEach(0..<12) { index in
                let month = months[index]
                GridNoteLabel(text: month)
                
                if months[index] != months.last {
                    Spacer()
                }
            }
        }
        .padding(.leading, 28)
        .padding(.trailing, 48)
    }
}

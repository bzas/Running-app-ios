//
//  WorkoutMenu.swift
//
//  Created by Alfonso Boizas Crespo on 15/11/25.
//

import SwiftUI

struct WorkoutMenu: View {
    
    init() {}
    
    var body: some View {
        Menu {
            Button {
                print("Share")
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            
            Button {
                print("Edit")
            } label: {
                Label("Edit", systemImage: "square.and.pencil")
            }
            
            Button(role: .destructive) {
                print("Delete")
            } label: {
                Label("Delete", systemImage: "trash")
            }
        } label: {
            Image(systemName: "ellipsis")
                .clipShape(Circle())
        }
    }
}

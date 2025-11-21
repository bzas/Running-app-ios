//
//  GalleryView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 21/11/25.
//

import SwiftUI

struct GalleryView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal) {
                    LazyHStack {
                        Color(uiColor: .black)
                            .aspectRatio(1.0, contentMode: .fill)
                            .clipShape(
                                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            )
                        Color(uiColor: .black)
                            .aspectRatio(1.0, contentMode: .fill)
                            .clipShape(
                                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            )
                        Color(uiColor: .black)
                            .aspectRatio(1.0, contentMode: .fill)
                            .clipShape(
                                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                            )
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: Finish
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add")
                        }
                        .padding(.horizontal, 8)
                        .clipShape(Capsule())
                    }
                }
            }
        }
        .presentationBackgroundInteraction(.enabled)
        .presentationDetents([.fraction(0.3)])
    }
}

#Preview {
    GalleryView()
}

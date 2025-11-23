//
//  GalleryView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 21/11/25.
//

import SwiftUI
import PhotosUI

struct GalleryView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel

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
                PhotosPicker(selection: $viewModel.selectedPhoto) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                    .padding(.horizontal, 8)
                    .clipShape(Capsule())
                }
            }
        }
        .onChange(of: viewModel.selectedPhoto, {
            viewModel.storePhoto()
        })
        .presentationBackgroundInteraction(.enabled)
        .presentationDetents([.fraction(0.3)])
    }
}

#Preview {
    GalleryView()
}

//
//  GalleryView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 21/11/25.
//

import SwiftUI
import PhotosUI
import Common

struct GalleryView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel
    var nameSpace: Namespace.ID
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.session.photos.isEmpty {
                    PlaceholderView(type: .images)
                } else {
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(viewModel.session.photos) {  photoItem in
                                PhotoCellView(
                                    photoItem: photoItem,
                                    nameSpace: nameSpace,
                                    selectedPhotoItem: $viewModel.presentedPhoto
                                )
                            }
                        }
                        .padding()
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .navigationTitle("Gallery")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                PhotosPicker(selection: $viewModel.selectedPhoto, matching: .images) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add")
                    }
                    .padding(.horizontal, 8)
                }
                .buttonStyle(.borderedProminent)
                .clipShape(Capsule())
            }
            .onChange(of: viewModel.selectedPhoto) {
                viewModel.storePhoto()
            }
        }
        .presentationBackgroundInteraction(.enabled)
        .presentationDetents([.fraction(0.3)])
        .fullScreenCover(item: $viewModel.presentedPhoto) { photoItem in
            PhotoDetailView(
                photoItem: photoItem,
                nameSpace: nameSpace,
                selectedPhotoItem: $viewModel.presentedPhoto,
                onDeleteImage: {
                    viewModel.deletePhoto(photoItem)
                }
            )
        }
    }
}

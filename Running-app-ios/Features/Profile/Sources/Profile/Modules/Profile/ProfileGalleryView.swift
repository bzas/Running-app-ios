//
//  ProfileGalleryView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 29/11/25.
//


import SwiftUI
import PhotosUI
import Common

struct ProfileGalleryView: View {
    
    @EnvironmentObject var viewModel: ProfileViewModel
    var nameSpace: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Gallery")
                .font(.title2)
                .fontWeight(.semibold)
            
            if viewModel.photos.isEmpty {
                VStack {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 30,
                            height: 30
                        )
                    Text("No photos added yet")
                }
                .foregroundStyle(.tertiary)
                .frame(maxWidth: .infinity)
                .padding()
            } else {
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(viewModel.photos) {  photoItem in
                            PhotoCellView(
                                photoId: photoItem.id,
                                photoData: photoItem.data,
                                nameSpace: nameSpace
                            )
                            .onTapGesture {
                                viewModel.presentedPhoto = photoItem
                            }
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
        }
        .frame(height: 200)
    }
}

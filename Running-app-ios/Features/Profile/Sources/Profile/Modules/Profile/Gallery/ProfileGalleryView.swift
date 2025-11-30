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
                .font(.title3)
                .fontWeight(.semibold)
            
            if viewModel.photos.isEmpty {
                ProfileGalleryPlaceholderView()
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

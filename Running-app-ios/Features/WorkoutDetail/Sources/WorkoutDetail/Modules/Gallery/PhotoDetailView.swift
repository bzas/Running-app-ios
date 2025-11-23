//
//  DetailPhotoView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Common

struct PhotoDetailView: View {
    
    var photoItem: PhotoItem
    var nameSpace: Namespace.ID
    @Binding var selectedPhotoItem: PhotoItem?
    
    var body: some View {
        NavigationStack {
            Image(uiImage: photoItem.image)
                .resizable()
                .scaledToFit()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            selectedPhotoItem = nil
                        } label: {
                            Image(systemName: "xmark")
                                .clipShape(Circle())
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            // TODO: Finish
                        } label: {
                            Image(systemName: "ellipsis")
                                .clipShape(Capsule())
                        }
                    }
                }
                .onTapGesture {
                    selectedPhotoItem = nil
                }
        }
        .navigationTransition(
            .zoom(
                sourceID: TransitionManager.detailImageTransitionId(for: photoItem.id),
                in: nameSpace
            )
        )
    }
}

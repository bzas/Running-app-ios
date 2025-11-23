//
//  PhotoCellView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Common

struct PhotoCellView: View {
    
    var photoItem: PhotoItem
    var nameSpace: Namespace.ID
    @Binding var selectedPhotoItem: PhotoItem?

    var body: some View {
        Image(uiImage: photoItem.image)
            .resizable()
            .aspectRatio(1.0, contentMode: .fill)
            .clipShape(
                RoundedRectangle(
                    cornerSize: CGSize(
                        width: 10,
                        height: 10
                    )
                )
            )
            .matchedTransitionSource(
                id: TransitionManager.detailImageTransitionId(for: photoItem.id),
                in: nameSpace
            )
            .onTapGesture {
                selectedPhotoItem = photoItem
            }
    }
}

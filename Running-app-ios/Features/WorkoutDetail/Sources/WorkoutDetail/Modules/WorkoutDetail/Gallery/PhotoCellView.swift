//
//  PhotoCellView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Common
import Domain

struct PhotoCellView: View {
    
    var photoItem: SessionPhoto
    var nameSpace: Namespace.ID
    @Binding var selectedPhotoItem: SessionPhoto?

    var body: some View {
        Image(uiImage: ImageFetchManager.fetchImage(from: photoItem.data))
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

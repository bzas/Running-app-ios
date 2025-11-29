//
//  PhotoCellView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI

public struct PhotoCellView: View {
    
    let photoId: UUID
    let photoData: Data
    var nameSpace: Namespace.ID
    
    public init(
        photoId: UUID,
        photoData: Data,
        nameSpace: Namespace.ID
    ) {
        self.photoId = photoId
        self.photoData = photoData
        self.nameSpace = nameSpace
    }

    public var body: some View {
        Image(uiImage: ImageFetchManager.fetchImage(from: photoData))
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
                id: TransitionManager.detailImageTransitionId(for: photoId),
                in: nameSpace
            )
    }
}

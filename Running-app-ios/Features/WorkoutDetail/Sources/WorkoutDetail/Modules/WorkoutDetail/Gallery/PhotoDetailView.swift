//
//  DetailPhotoView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import Common
import Domain
import UniformTypeIdentifiers

struct PhotoDetailView: View {
    
    var photoItem: SessionPhoto
    var nameSpace: Namespace.ID
    @Binding var selectedPhotoItem: SessionPhoto?
    var onDeleteImage: () -> Void
    var uiImage: UIImage

    init(
        photoItem: SessionPhoto,
        nameSpace: Namespace.ID,
        selectedPhotoItem: Binding<SessionPhoto?>,
        onDeleteImage: @escaping () -> Void
    ) {
        self.photoItem = photoItem
        self.nameSpace = nameSpace
        self._selectedPhotoItem = selectedPhotoItem
        self.onDeleteImage = onDeleteImage
        self.uiImage = ImageFetchManager.fetchImage(from: photoItem.data)
    }
    
    var body: some View {
        NavigationStack {
            Image(uiImage: uiImage)
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
                        Menu {
                            ShareLink(
                                item: ShareablePhoto(image: ImageFetchManager.fetchImage(from: photoItem.data)),
                                preview: SharePreview(
                                    "Photo",
                                    image: Image(uiImage: ImageFetchManager.fetchImage(from: photoItem.data))
                                )
                            ) {
                                Label(
                                    "Share",
                                    systemImage: "square.and.arrow.up"
                                )
                            }
                            
                            Button(
                                "Delete",
                                systemImage: "trash",
                                role: .destructive
                            ) {
                                onDeleteImage()
                            }
                        } label: {
                            Image(systemName: "ellipsis")
                                .clipShape(Capsule())
                        }
                    }
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

private struct ShareablePhoto: Transferable {
    let image: UIImage

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .png) { photo in
            guard let data = photo.image.pngData() else {
                throw ExportError.exportFailed
            }
            return data
        }
    }

    enum ExportError: Error {
        case exportFailed
    }
}

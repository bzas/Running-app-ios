//
//  DetailPhotoView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 23/11/25.
//

import SwiftUI
import UniformTypeIdentifiers

public struct PhotoDetailView: View {
    
    var nameSpace: Namespace.ID
    var onDeleteImage: () -> Void
    var onDismiss: () -> Void
    var uiImage: UIImage

    public init(
        imageData: Data,
        nameSpace: Namespace.ID,
        onDeleteImage: @escaping () -> Void,
        onDismiss: @escaping () -> Void
    ) {
        self.nameSpace = nameSpace
        self.onDeleteImage = onDeleteImage
        self.onDismiss = onDismiss
        self.uiImage = ImageFetchManager.fetchImage(from: imageData)
    }
    
    public var body: some View {
        NavigationStack {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            onDismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .clipShape(Circle())
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            ShareLink(
                                item: ShareablePhoto(image: uiImage),
                                preview: SharePreview(
                                    "Photo",
                                    image: Image(uiImage: uiImage)
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

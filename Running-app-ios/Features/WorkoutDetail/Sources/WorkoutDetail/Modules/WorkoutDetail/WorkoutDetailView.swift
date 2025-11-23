//
//  SwiftUIView.swift
//  Workouts
//
//  Created by Alfonso Boizas Crespo on 15/11/25.
//

import SwiftUI
import Common

public struct WorkoutDetailView: View {
    
    @StateObject var viewModel: WorkoutDetailViewModel
    var nameSpace: Namespace.ID
    
    public init(
        viewModel: WorkoutDetailViewModel,
        nameSpace: Namespace.ID
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.nameSpace = nameSpace
    }
    
    public var body: some View {
        ZStack {
            WorkoutMap(
                sessionRoute: viewModel.session.locationPoints,
                isInDetail: true
            )
            
            VStack {
                Spacer()
                HStack {
                    InfoButton(nameSpace: nameSpace)
                        .environmentObject(viewModel)
                    
                    GalleryButton(nameSpace: nameSpace)
                        .environmentObject(viewModel)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.onDismiss()
                } label: {
                    Image(systemName: "xmark")
                        .clipShape(Circle())
                }
            }
        }
    }
}

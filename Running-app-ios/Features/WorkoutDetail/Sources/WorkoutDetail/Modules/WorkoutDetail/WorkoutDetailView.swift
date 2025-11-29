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
        WorkoutMap(
            sessionRoute: viewModel.session.locationPoints,
            isInDetail: true
        )
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.onDismiss()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            
            ToolbarItemGroup(placement: .bottomBar) {
                WorkoutDetailBottomBarView(nameSpace: nameSpace)
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            viewModel.setup()
        }
    }
}

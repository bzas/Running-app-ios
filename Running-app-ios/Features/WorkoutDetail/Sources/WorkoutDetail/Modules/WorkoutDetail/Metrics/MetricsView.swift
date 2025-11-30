//
//  MetricsView.swift
//  WorkoutDetail
//
//  Created by Alfonso Boizas Crespo on 26/11/25.
//

import SwiftUI

struct MetricsView: View {
    
    @EnvironmentObject var viewModel: WorkoutDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            SectionTitleView(title: "Metrics")

            VStack(spacing: 32) {
                MetricsSummaryView(session: viewModel.session)
                
                CadenceView()
                    .environmentObject(viewModel)
            }
            
            Spacer()
        }
        .padding(
            EdgeInsets(
                top: 32,
                leading: 32,
                bottom: 8,
                trailing: 32
            )
        )
        .presentationBackgroundInteraction(.enabled)
        .presentationDetents([.fraction(0.5)])
    }
}

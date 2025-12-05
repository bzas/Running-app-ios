//
//  GridHeaderView.swift
//  Profile
//
//  Created by Alfonso Boizas Crespo on 30/11/25.
//

import SwiftUI
import Localization

struct GridHeaderView: View {
    
    private let months = [
        Localizables.Profile.Months.jan,
        Localizables.Profile.Months.feb,
        Localizables.Profile.Months.mar,
        Localizables.Profile.Months.apr,
        Localizables.Profile.Months.may,
        Localizables.Profile.Months.jun,
        Localizables.Profile.Months.jul,
        Localizables.Profile.Months.aug,
        Localizables.Profile.Months.sep,
        Localizables.Profile.Months.oct,
        Localizables.Profile.Months.nov,
        Localizables.Profile.Months.dec
    ]
    
    var body: some View {
        HStack {
            ForEach(0..<12) { index in
                let month = months[index]
                GridNoteLabel(text: month)
                
                if months[index] != months.last {
                    Spacer()
                }
            }
        }
        .padding(.leading, 28)
        .padding(.trailing, 48)
    }
}

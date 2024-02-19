//
//  StatisticRow.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 18/02/24.
//

import SwiftUI

struct StatisticRow: View {
    // MARK: Properties
    let stat: Statistic
    
    // MARK: View
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(.dcSecondaryText)
            
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(.accent)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            } // HStack
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? Color.dcGreen : Color.dcRed)
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
        } // VStack
    }
}

// MARK: - Previews
#Preview("Light",traits: .sizeThatFitsLayout) {
    Group {
        StatisticRow(stat: MockData.stat1)
    }
}

#Preview("Dark",traits: .sizeThatFitsLayout) {
    StatisticRow(stat: MockData.stat2)
        .preferredColorScheme(.dark)
}

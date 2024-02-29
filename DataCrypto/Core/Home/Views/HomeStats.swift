//
//  HomeStats.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 18/02/24.
//

import SwiftUI

struct HomeStats: View {
    // MARK: Properties
    @State private var homeViewModel = HomeViewModel()
    
    // MARK: View
    var body: some View {
        VStack {HStack {
                ForEach(homeViewModel.statistics) { stat in
                    StatisticRow(stat: stat)
                        .frame(width: width / 3)
                } // Loop
            } // HStack
            .task {
                await homeViewModel.getMarketData()
            } // Task
        } // VStack
    }
}

// MARK: Preview
#Preview {
    HomeStats()
}

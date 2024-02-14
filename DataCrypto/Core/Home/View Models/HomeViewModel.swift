//
//  HomeViewModel.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 14/02/24.
//

import Foundation
import Observation

@Observable
class HomeViewModel {
    
    var allCoins: [Coin] = []
    var portfolioCoins: [Coin] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(MockData.coin)
            self.portfolioCoins.append(MockData.coin)
        }
    }
}

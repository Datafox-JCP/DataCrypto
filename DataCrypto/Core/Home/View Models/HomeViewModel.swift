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
    var coinError: ErrorCases?
    var showAlert = false
    var isLoading = false
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(MockData.coin)
            self.portfolioCoins.append(MockData.coin)
        }
    }
    
    func getAllCoins() async {
        isLoading = true
        do {
            self.allCoins = try await CoinsWebService.getAllCoins()
            self.isLoading = false
        } catch(let error) {
            coinError = ErrorCases.custom(error: error)
            showAlert = true
            isLoading = false
        }
    }
    
}

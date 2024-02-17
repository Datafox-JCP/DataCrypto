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
    var topCoins: [Coin] = []
    var portfolioCoins: [Coin] = []
    var coinError: ErrorCases?
    var showAlert = false
    var isLoading = false
    var searchText = ""
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(MockData.coin)
            self.portfolioCoins.append(MockData.coin)
        }
//        getData()
    }
    
    func getData() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("DEBUG: Error \(error.localizedDescription)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("DEBUG: Response code \(response.statusCode)")
                return
            }
            
            guard let data = data else { return }
            let dataAsString = String(data: data, encoding: .utf8)
            print("DEBUG: Data \(dataAsString ?? "no data decoded")")
            
            do {
                let coins = try JSONDecoder().decode([Coin].self, from: data)
                print("DEBUG: Coins \(coins)")
//                DispatchQueue.main.async {
//                    self.allCoins = coins
//                    self.getTopCoins()
//                }
            } catch let error {
                print("DEBUG Failed to decode with error \(error.localizedDescription)")
            }
        }
        .resume()
    }
    
    func getAllCoins() async {
        isLoading = true
        do {
            self.allCoins = try await CoinsWebService.fetchCoinData()
            self.getTopCoins()
            self.isLoading = false
        } catch(let error) {
            coinError = ErrorCases.custom(error: error)
            showAlert = true
            isLoading = false
        }
    }
    
    func getTopCoins() {
        let topMovers = allCoins.sorted {
            $0.priceChangePercentage24H ?? 0 > $1.priceChangePercentage24H ?? 0
        }
        topCoins = Array(topMovers.prefix(10))
    }
}

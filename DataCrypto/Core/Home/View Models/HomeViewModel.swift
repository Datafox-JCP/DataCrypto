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
    var filterCoins: [Coin] = []
    var topCoins: [Coin] = []
    var maketData: MarketData?
    var statistics: [Statistic] = []
    var coinError: ErrorCases?
    var showAlert = false
    var isLoading = false
    var sortOption = SortOption.rank // para ordenamiento
    
//    let statistics: [Statistic] = [
//        Statistic(title: "Title", value: "Value", percentageChange: 1),
//        Statistic(title: "Title", value: "Value")
//        Statistic(title: "Title", value: "Value", percentageChange: -12)
//    ]
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(MockData.coin)
        }
//        getData()
    }
    
    func getAllCoins() async {
        isLoading = true
        do {
            self.allCoins = try await CoinsWebService.fetchCoinData()
            self.filterCoins = self.allCoins
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
    
    func getMarketData() async {
        isLoading = true
        do {
            maketData = try await CoinsWebService.fetchMarketData()
            statistics = mapGlobalMarketData(marketData: maketData)
            self.isLoading = false
        } catch(let error) {
            coinError = ErrorCases.custom(error: error)
            showAlert = true
            isLoading = false
        }
    }
    
    func search(with query: String) {
        let searchText = query.lowercased()
        filterCoins = query.isEmpty ? allCoins : allCoins.filter {
            $0.name.lowercased().contains(searchText)
            || $0.symbol.lowercased().contains(searchText)
        }
    }
    
    func sortCoins(sort: SortOption) {
        switch sort {
        case .rank:
            filterCoins.sort(by: { $0.marketCapRank < $1.marketCapRank })
//            return coins.sorted { coin1, coin2 in
//                return coin1.marketCapRank < coin2.marketCapRank
//            }
        case .rankReversed:
            filterCoins.sort(by: { $0.marketCapRank > $1.marketCapRank })
        case .price:
            filterCoins.sort(by: { $0.currentPrice < $1.currentPrice })
        case .priceReverse:
            filterCoins.sort(by: { $0.currentPrice > $1.currentPrice })
        }
    }
    
    private func mapGlobalMarketData(marketData: MarketData?) -> [Statistic] {
        var stats: [Statistic] = []
    
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = Statistic(title: "Cap. Mercado", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "Volumen 24h", value: data.volume)
        let btcDominance = Statistic(title: "Dominio BTC", value: data.btcDominance)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance
        ])
        return stats
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
}

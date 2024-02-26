//
//  DetailViewModel.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 22/02/24.
//

import Foundation
import Observation

@Observable
final class DetailViewModel {
    
    var coinInfo: CoinDetail?
    var coin: Coin?
    var coinError: ErrorCases?
    var showAlert = false
    var isLoading = false
    
    func fetchDetails(for id: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            self.coinInfo = try await CoinDetailWebService().fetchCoinDetails(for: id)
            print(coinInfo as Any)
        } catch(let error) {
            coinError = ErrorCases.custom(error: error)
            showAlert = true
        }
    }
    
//    private func mapCoinDetails(coinDetails: CoinDetail?) -> [Statistic] {
//        
//        let price = coin?.currentPrice.asCurrencyWith6Decimals() ?? ""
//        let priceChange = coin?.priceChangePercentage24H
//        let priceStat = Statistic(title: "Precio actual", value: price, percentageChange: priceChange)
//        
//        let marketCap = "$" + (coin?.marketCap?.formattedWithAbbreviations() ?? "")
//        let marketCapChange = coin?.marketCapChangePercentage24H
//        let marketCapStat = Statistic(title: "Cap de Mercado", value: marketCap, percentageChange: marketCapChange)
//        
////        let rank = "\(coin.rank)"
//        
//        let volume = "$" + (coin?.totalVolume?.formattedWithAbbreviations() ?? "")
//        let volumeStat = Statistic(title: "Voumen", value: volume)
//        
//        let overviewArray: [Statistic] = [
//            priceStat, marketCapStat, volumeStat
//        ]
//        
//        return overviewArray
//    }
}

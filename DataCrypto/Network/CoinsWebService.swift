//
//  CoinsWebService.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 15/02/24.
//

import Foundation

final class CoinsWebService {
    
    static func fetchCoinData() async throws -> [Coin] {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=MXN&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
            throw ErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Coin].self, from: data)
        } catch {
            throw ErrorCases.invalidData
        }
    }
    
    static func fetchMarketData() async throws -> MarketData {
        let urlString = "https://api.coingecko.com/api/v3/global"
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
            throw ErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let receiveValue = try decoder.decode(GlobalData.self, from: data)
            #if DEBUG
            let marketData = receiveValue.data!
            print("👾 MarketValue value: \(marketData)")
            #endif
            return receiveValue.data!
        } catch {
            throw ErrorCases.invalidData
        }
    }
}

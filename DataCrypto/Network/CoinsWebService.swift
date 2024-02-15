//
//  CoinsWebService.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 15/02/24.
//

import Foundation

final class CoinsWebService {
    
    static func getAllCoins() async throws -> [Coin] {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
            throw ErrorCases.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode([Coin].self, from: data)
        } catch {
            throw ErrorCases.invalidData
        }
    }
}

//
//  CoinDetailWebService.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 22/02/24.
//

import Foundation

class CoinDetailWebService {
    
    func fetchCoinDetails(for id: String) async throws -> CoinDetail {
        let urlString = "https://api.coingecko.com/api/v3/coins/\(id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        
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
            return try decoder.decode(CoinDetail.self, from: data)
        } catch {
            throw ErrorCases.invalidData
        }
    }
}

//
//  CoinDetail.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 22/02/24.
//

import Foundation

// https://www.coingecko.com/api/documentation

struct CoinDetail: Codable, Identifiable {
    let id, symbol, name: String
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let categories: [String]?
    let description: Description?
    let links: Links?
    
    var noHTMLdescription: String? {
        description?.en?.removeHTMOcurrances
    }
}


// MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
}

// MARK: - Description
struct Description: Codable {
    let en: String?
}

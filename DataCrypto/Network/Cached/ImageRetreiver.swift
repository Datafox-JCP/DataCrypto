//
//  ImageRetreiver.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 16/02/24.
//

import Foundation

struct ImageRetriver {
    
    func fetch(_ imgURL: String) async throws -> Data {
        guard let url = URL(string: imgURL) else {
            throw ErrorCases.invalidUrl
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}

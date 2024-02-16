//
//  ErrorCases.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 15/02/24.
//

import Foundation

enum ErrorCases: LocalizedError {
    case invalidUrl
    case invalidResponse
    case invalidData
    case custom(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl: return "Invalid URL"
            
        case .invalidResponse: return "The server has some problems. Please try gain in a few minutes."
            
        case .invalidData: return "Invalid data"
            
        case .custom(let error):
            return error.localizedDescription
        }
    }
    
}

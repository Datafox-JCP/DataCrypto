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
        case .invalidUrl: return "URL no válida"
            
        case .invalidResponse: return "Respuesta no válida"
            
        case .invalidData: return "Datos inválidos"
            
        case .custom(let error):
            return error.localizedDescription
        }
    }
    
}

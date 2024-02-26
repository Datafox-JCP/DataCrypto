//
//  String+Extension.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 26/02/24.
//

import Foundation

extension String {
    
    var removeHTMOcurrances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

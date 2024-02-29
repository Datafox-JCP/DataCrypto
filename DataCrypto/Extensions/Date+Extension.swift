//
//  Date+Extension.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 29/02/24.
//

import Foundation

extension Date {
    
    // "2013-07-06T00:00:00.000Z"
    init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    func toShortDateString() -> String {
        shortFormatter.string(from: self)
    }
}

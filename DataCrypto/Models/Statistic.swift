//
//  Statistic.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 18/02/24.
//

import Foundation

struct Statistic: Identifiable, Hashable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(
        title: String,
        value: String,
        percentageChange: Double? = nil
    ) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}

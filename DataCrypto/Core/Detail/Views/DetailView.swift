//
//  DetailView.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 21/02/24.
//

import SwiftUI

struct DetailView: View {
    // MARK: Properties
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        print("👀 Iniciando Detail View para \(coin.name)")
    }
    
    var body: some View {
        Text(coin.name)
            .navigationTitle("Detalles")
    }
}

#Preview {
    DetailView(coin: MockData.coin)
}

//
//  CoinRow.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 13/02/24.
//

import SwiftUI

struct CoinRow: View {
    // 1
    let coin: Coin
    // 5
    let showHoldingsColumn: Bool
    
    var body: some View {
        // 3
        HStack(spacing: 0) {
            leftColumn
            
            Spacer()
            
            // 6
            if showHoldingsColumn {
                centerColumn
            } // Condition
            
            Spacer()
            
            rightColumn
        } // HStack
        .font(.subheadline)
    }
}

#Preview("Light",traits: .sizeThatFitsLayout) {
    // 2 Crear MockData
    CoinRow(coin: MockData.coin, showHoldingsColumn: true)
}

#Preview("Dark",traits: .sizeThatFitsLayout) {
    // 2 Crear MockData
    CoinRow(coin: MockData.coin, showHoldingsColumn: true)
        .preferredColorScheme(.dark)
}

extension CoinRow {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
                // 4 Ya terminado el diseño poner la imagen
    //            Circle()
    //                .frame(width: 45, height: 45)
    //            AsyncImage(url: URL(string: coin.image), scale: 6.0)
                // primero sin scale y al final la siguiente primero sin transcation
                AsyncImage(url: URL(string: coin.image), transaction: Transaction(animation: .spring())) { phase in
                    switch phase {
                    case .empty:
                        Color.purple.opacity(0.1)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_):
                        Image(systemName: "exclamationmark.icloud")
                            .resizable()
                            .scaledToFit()
                    @unknown default:
                        Image(systemName: "exclamationmark.icloud")
                    }
                }
                .frame(width: 45, height: 45)
                    
                
                VStack(alignment: .leading) {
                    Text(coin.symbol.uppercased())
                        .font(.title2)
                        .padding(.leading, 8)
                        .foregroundStyle(.accent)
                    
                    Text(coin.name.uppercased())
                        .font(.caption)
                        .padding(.leading, 8)
                        .foregroundStyle(.dcSecondaryText)
                } // VStack
                .padding(.leading, 8)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            
            Text((coin.currentHoldings ?? 0).asNumberString())
                .font(.caption)
                .padding(.leading, 8)
                .foregroundStyle(.dcSecondaryText)
        } // VSTack
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(.accent)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .font(.caption)
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? .dcGreen : .dcRed)
        } // VStack
        // para centrar
//            .frame(width: UIScreen.main.bounds.width / 3.5)
        // reemplazar por ya que sólo se usará en Portrait
        .frame(width: width / 3.5)
    }
}

//
//  CoinRow.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 13/02/24.
//

import SwiftUI

struct CoinRow: View {
    // MARK: Properties
    let coin: Coin
    let showHoldingsColumn: Bool
    
    // MARK: View
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            
            Spacer()
            
            if showHoldingsColumn {
                centerColumn
            } // Condition
            
            Spacer()
            
            rightColumn
        } // HStack
        .font(.subheadline)
        .padding(.all, 8)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 2)
        }
    }
}

// MARK: - Previews
#Preview("Light",traits: .sizeThatFitsLayout) {
    CoinRow(coin: MockData.coin, showHoldingsColumn: true)
}

#Preview("Dark",traits: .sizeThatFitsLayout) {
    CoinRow(coin: MockData.coin, showHoldingsColumn: true)
        .preferredColorScheme(.dark)
}

// MARK: - Extensions
extension CoinRow {
    
    // MARK: - Left column
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.marketCapRank)")
                .padding(.trailing, 8)
                .font(.caption)
                .foregroundStyle(.accent)

            AsyncImage(url: URL(string: coin.image), transaction: Transaction(animation: .easeIn(duration: 1))) { phase in
                    switch phase {
                    case .empty:
                        Color.clear
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
                .frame(width: 32, height: 32)
                    
                
                VStack(alignment: .leading) {
                    Text(coin.symbol.uppercased())
                        .font(.headline)
                        .padding(.leading, 8)
                        .foregroundStyle(.accent)
                    
                    Text(coin.name.uppercased())
                        .font(.caption)
                        .padding(.leading, 8)
                        .foregroundStyle(.dcSecondaryText)
                } // VStack
                .padding(.leading, 8)
        } // HStack
    }
    
    // MARK: - Center column
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
    
    // MARK: - Right column
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundStyle(.accent)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .font(.caption)
                .foregroundStyle((coin.priceChangePercentage24H ?? 0) >= 0 ? .dcGreen : .dcRed)
        } // VStack
        .frame(width: width / 3.5, alignment: .trailing)
    }
}

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
            CachedImage(
                url: coin.image,
                animation: .easeIn(duration: 0.5),
                transition: .scale.combined(with: .opacity)
            ) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(_):
                    Image(systemName: "xmark")
                        .symbolVariant(.circle.fill)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 32, height: 32)
                
                VStack(alignment: .leading) {
                    Text(coin.name.uppercased())
                        .font(.headline)
                        .foregroundStyle(.accent)
                    
                    HStack {
                        Text("\(coin.marketCapRank)")
                        
                        Text(coin.symbol.uppercased())
                    }
                    .font(.caption)
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
                .padding(.horizontal, 2)
        } // VStack
        .frame(width: width / 3.5, alignment: .trailing)
    }
}

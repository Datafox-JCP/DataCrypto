//
//  TopCoinsRow.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 14/02/24.
//

import SwiftUI

struct TopCoinsRow: View {
    // MARK: Properties
    let coin: Coin
    
    // MARK: View
    var body: some View {
        VStack(alignment: .leading) {
            CachedImage(
                url: coin.image,
                animation: .spring(duration: 0.5),
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
            
            HStack(spacing: 4) {
                Text(coin.name)
                    .font(.caption)
                    .bold()
                
                Text(coin.currentPrice.asCurrencyWith2Decimals())
                    .font(.caption)
                    .foregroundStyle(.dcSecondaryText)
            } // HStack

            Text(coin.priceChangePercentage24H?.asPercentString() ?? "-")
                .font(.callout)
                .foregroundStyle(.dcGreen)
        } // VStack
        .frame(width: 110, height: 110)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 2)
        } // Overlay
    }
}

// MARK: - Previews
#Preview("Light") {
    TopCoinsRow(coin: MockData.coin)
}

#Preview("Dark") {
    TopCoinsRow(coin: MockData.coin)
        .preferredColorScheme(.dark)
}

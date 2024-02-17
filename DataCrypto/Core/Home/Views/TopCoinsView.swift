//
//  TopCoinsView.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 14/02/24.
//

import SwiftUI

struct TopCoinsView: View {
    let coin: Coin
    
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
            .frame(width: 36, height: 36)
//            AsyncImage(url: URL(string: coin.image), transaction: Transaction(animation: .spring())) { phase in
//                switch phase {
//                case .empty:
//                    Color.orange.opacity(0.3)
//                case .success(let image):
//                    image
//                        .resizable()
//                        .scaledToFill()
//                case .failure(_):
//                    Image(systemName: "exclamationmark.icloud")
//                        .resizable()
//                        .scaledToFit()
//                @unknown default:
//                    Image(systemName: "exclamationmark.icloud")
//                }
//            }
//            .frame(width: 32, height: 32)
            
            HStack(spacing: 2) {
                Text(coin.name)
                    .font(.caption)
                    .bold()
                
                Text(coin.currentPrice.asCurrencyWith2Decimals())
                    .font(.caption)
                    .foregroundStyle(.dcSecondaryText)
            }

            Text(coin.priceChangePercentage24H?.asPercentString() ?? "-")
                .foregroundStyle(.dcGreen)
        }
        .frame(width: 140, height: 140)
        .background(.blue.opacity(0.1))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 2)
        }
    }
}

#Preview("Light") {
    TopCoinsView(coin: MockData.coin)
}

#Preview("Dark") {
    TopCoinsView(coin: MockData.coin)
        .preferredColorScheme(.dark)
}

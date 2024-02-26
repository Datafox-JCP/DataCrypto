//
//  DetailView.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 21/02/24.
//

import SwiftUI

struct DetailView: View {
    // MARK: Properties
    @State private var detailViewModel = DetailViewModel()
    @State private var showFullDescription = false
    
    let coin: Coin
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                CachedImage(
                    url: coin.image,
                    animation: .spring(duration: 2.0),
                    transition: .move(edge: .top) .combined(with: .opacity)
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
                    } // Phase
                } // Image
                .frame(width: 150, height: 150)
                
                Text(detailViewModel.coinInfo?.name ?? "")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.accent)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                ZStack {
//                    if let description = detailViewModel.coinInfo?.description?.en {
//                        Text(description)
//                    } // antes de quitar el HTML
                    if let description = detailViewModel.coinInfo?.noHTMLdescription {
                        VStack(alignment: .leading) {
                            Text(description)
                                .font(.callout)
                                .foregroundStyle(.dcSecondaryText)
                                .lineLimit(showFullDescription ? nil : 5)
                            
                            Button {
                                withAnimation(.easeInOut) {
                                    showFullDescription.toggle()
                                }
                            } label: {
                                Text(showFullDescription ? "Menos" : "Leer más")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .padding(.vertical, 4)
                            }
                            .tint(.blue)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .padding(.horizontal)
            } // VStack
        } // Scroll
        .navigationTitle(detailViewModel.coinInfo?.name ?? "")
        .task {
            await detailViewModel.fetchDetails(for: coin.id)
        } // Load task
    }
}

//#Preview {
//    DetailView(coin: MockData.coin)
//}

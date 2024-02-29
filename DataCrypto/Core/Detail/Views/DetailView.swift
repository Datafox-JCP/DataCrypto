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
        ZStack {
            Color.dcBackground
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    ChartView(coin: coin)
                        .padding(.vertical)
                    VStack(spacing: 20) {
                        coinDescription
                        Divider()
                    }
                    .padding()
                    
                } // VStack
            } // Scroll
        } // ZStack
        .navigationTitle(detailViewModel.coinInfo?.name ?? "")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItems
            } // Item
        } // Toolbar
        .task {
            await detailViewModel.fetchDetails(for: coin.id)
        } // Load task
    }
}

//#Preview {
//    DetailView(coin: MockData.coin)
//}


extension DetailView {
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(detailViewModel.coinInfo?.symbol.uppercased() ?? "")
                .font(.headline)
                .foregroundStyle(.dcSecondaryText)
            
            CachedImage(
                url: coin.image
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
            .frame(width: 25, height: 25)
        }
    }
    
    private var coinDescription: some View {
        ZStack {
            if let description = detailViewModel.coinInfo?.noHTMLdescription {
                VStack(alignment: .leading) {
                    Text(description)
                        .font(.callout)
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
                    } // Description button
                    .tint(.blue)
                } // VStack
                .frame(maxWidth: .infinity, alignment: .leading)
            } // Condition
        } // Zstack
        .padding(.horizontal)
    }
}

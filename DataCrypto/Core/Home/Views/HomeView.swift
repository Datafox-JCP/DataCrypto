//
//  HomeView.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 11/02/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: Properties
    
    @State private var homeViewModel = HomeViewModel()
    @State private var query = ""
    @State private var showPortfolio: Bool = false
    
    // MARK: - View
    var body: some View {
        NavigationStack {
            ZStack {
                Color.dcBackground
                    .ignoresSafeArea()
                
                VStack {
                    HomeStats()
                        .padding(.bottom, 6)
                    topCoins
                    titles
                    coinsList
                } // VStack
            } // ZStack
            .navigationTitle("Precios Cripto")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "gear")
                            .padding(.horizontal)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "bitcoinsign")
                            .symbolVariant(.circle)
                            .padding(.horizontal)
                    }
                }
            }
            .searchable(
                text: $query,
                prompt: "Buscar por moneda o símbolo"
            )
            .onChange(of: query) {
                homeViewModel.search(with: query)
            } // Execute filter
            .overlay {
                if !homeViewModel.isLoading {
                    if homeViewModel.filterCoins.isEmpty {
                        ContentUnavailableView.search
                    } // Content unavailable
                } // Condition to show only if not is loading
            } // Overlay
        } // Nav
        // MARK: - Load coins
        .task {
            await homeViewModel.getAllCoins()
        } // Load data
        .alert(isPresented: $homeViewModel.showAlert) {
            return Alert(
                title: Text("Error"),
                message: Text(homeViewModel.coinError?.errorDescription ?? "")
            )
        } // Alert
    }
}

// MARK: - Previews
#Preview("Light") {
    HomeView()
}

#Preview("Dark") {
    HomeView()
        .preferredColorScheme(.dark)
}

// MARK: - Extension
extension HomeView {
    
    // MARK: - Top coins
    private var topCoins: some View {
        VStack {
            Text("Top 10")
                .font(.caption)
                .foregroundStyle(.dcSecondaryText)
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(homeViewModel.topCoins) { coin in
                            TopCoinsRow(coin: coin )
                        } // Loop
                    } // HStack
                } // Scroll
                .padding(.horizontal)
            } // VStack
            .padding(.bottom, 16)
        }
    }
    
    // MARK: - Coins list
    private var coinsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(homeViewModel.filterCoins) { coin in
                    CoinRow(coin: coin, showHoldingsColumn: false)
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                } // Loop
            } // LazyVStack
        } // Scroll
        .refreshable {
            await homeViewModel.getAllCoins()
        }
    }
    
    // MARK: - Titles
    private var titles: some View {
        HStack {
            Text("Moneda")
            Spacer()
            Text("Precio")
                .frame(width: width / 3, alignment: .trailing)
        } // HStack
        .font(.caption)
        .foregroundStyle(.dcSecondaryText)
        .padding(.horizontal, 36)
    }
}

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
    @State private var selectedCoin: Coin? = nil
    @State private var showDetailView = false
    
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
        .alert(homeViewModel.coinError?.errorDescription ?? "", isPresented: $homeViewModel.showAlert) {
            Button("Aceptar", role: .cancel) {}
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
            
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(homeViewModel.topCoins) { coin in
                            TopCoinsRow(coin: coin)
                        } // Loop
                    } // HStack
                } // Scroll
            } // VStack
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
    }
    
    // MARK: - Coins list
    private var coinsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(homeViewModel.filterCoins) { coin in
                    NavigationLink {
                        DetailView(coin: coin)
                    } label: {
                        CoinRow(coin: coin, showHoldingsColumn: false)
                            .padding(.horizontal)
                            .padding(.bottom, 12)
                    } // NavLink
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
            HStack(spacing: 4) {
                Text("Moneda")
                
                Image(systemName: "chevron.down")
                    .opacity((homeViewModel.sortOption == .rank || homeViewModel.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .rank ? 0 : 180))
            } // HStack
            .onTapGesture {
                homeViewModel.sortOption = homeViewModel.sortOption == .rank ? .rankReversed : .rank
                onTapSortButton(sortOption:  homeViewModel.sortOption)
            }
            
            Spacer()
            
            HStack(spacing: 4) {
                Text("Precio")
                
                Image(systemName: "chevron.down")
                    .opacity((homeViewModel.sortOption == .price || homeViewModel.sortOption == .priceReverse) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: homeViewModel.sortOption == .price ? 0 : 180))
            } // HStack
            .frame(width: width / 3, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    homeViewModel.sortOption = homeViewModel.sortOption == .price ? .priceReverse : .price
                    onTapSortButton(sortOption:  homeViewModel.sortOption)
                }
            } // Sort button
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    refreshData()
                    HapticManager.notification(type: .success)
                }
            } label: {
                Image(systemName: "goforward")
            } // Refresh button
            .rotationEffect(Angle(degrees: homeViewModel.isLoading ? 360 : 0), anchor: .center)
        } // HStack
        .font(.caption)
        .foregroundStyle(.dcSecondaryText)
        .padding(.horizontal, 36)
    }
    
    // MARK: Refresh function
    func refreshData() {
        Task {
            await homeViewModel.getAllCoins()
        }
    }
    
    // MARK: Sort function
    private func onTapSortButton(sortOption: SortOption) {
        homeViewModel.sortOption = sortOption
        homeViewModel.sortCoins(sort: sortOption)
    }
}

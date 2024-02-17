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
    @State private var showPortfolio = true
    
    // MARK: - View
    var body: some View {
        ZStack {
            Color.dcBackground
                .ignoresSafeArea()
            
            VStack {
                homeHeader
                topCoins
                titles
                
                SearchBar(searchText: $homeViewModel.searchText)
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                if homeViewModel.isLoading {
                    LoadingView()
                }
            } // VStack
        } // ZStack
        // 1 WebService - ErrorCases - ViewModel
        // MARK: - Load coins
        .task {
//            await homeViewModel.getAllCoins()
        }
        .alert(isPresented: $homeViewModel.showAlert) {
            return Alert(
                title: Text("Error"),
                message: Text(homeViewModel.coinError?.errorDescription ?? "")
            )  // 2 Add alert
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
    
    // MARK: - Header (butttons)
    private var homeHeader: some View {
        HStack {
            CircleButton(iconName: showPortfolio ? "plus" : "info")
                .animation(.none, value: showPortfolio)
                .background(
                    CircleButtonAnimation(animate: $showPortfolio)
                )
            
            Spacer()
            
          Text(showPortfolio ? "Holdings" : "Live Prices")
                .fontWeight(.heavy)
                .foregroundStyle(.accent)
                .animation(.none, value: showPortfolio)
            
            Spacer()
            
            CircleButton(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.interactiveSpring()) {
                        showPortfolio.toggle()
                    }
                }
        } // HStack
        .padding(.horizontal)
    }
    
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
                            TopCoinsView(coin: coin )
                        } // Loop
                    } // HStack
                } // Scroll
                .padding(.horizontal)
            } // VStack
            .padding(.bottom, 16)
        }
    }
    
    // MARK: - Coins list
    private var allCoinsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack {
                ForEach(homeViewModel.allCoins) { coin in
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
    
    // MARK: - Portfolio list
    private var portfolioCoinsList: some View {
        List {
            ForEach(homeViewModel.portfolioCoins) { coin in
                CoinRow(coin: coin, showHoldingsColumn: true)
                    .listRowSeparator(.hidden)
            }
        } // List
        .listStyle(.plain)
    }
    
    // MARK: - Titles
    private var titles: some View {
        HStack {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: width / 3, alignment: .trailing)
        } // HStack
        .font(.caption)
        .foregroundStyle(.dcSecondaryText)
        .padding(.horizontal, 36)
    }
}

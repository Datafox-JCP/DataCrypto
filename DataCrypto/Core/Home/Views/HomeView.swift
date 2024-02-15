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
                
                VStack(alignment: .leading) {
                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            ForEach(0..<5, id: \.self) { _ in
                                TopCoinsView()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 16)

                titles
                
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
        // primero crear el webservice
        // crear ErrorCases
        // crear función en ViewModel
        .task {
            await homeViewModel.getAllCoins()
        }
        // 2 después añadir la alerta
        .alert(isPresented: $homeViewModel.showAlert) {
            return Alert(
                title: Text("Error"),
                message: Text(homeViewModel.coinError?.errorDescription ?? "")
            )
        } // Alert
    }
}

// MARK: - Preview
#Preview("Light") {
    NavigationStack {
        HomeView()
            .toolbar(.hidden)
    }
}

#Preview("Dark") {
    NavigationStack {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

// MARK: - Extensions
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
                
              Text(showPortfolio ? "Portafolio" : "Precios Actuales")
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
    
    private var allCoinsList: some View {
        ScrollView {
            LazyVStack {
                ForEach(homeViewModel.allCoins) { coin in
                    CoinRow(coin: coin, showHoldingsColumn: false)
                        .padding(.horizontal)
                }
            }
        }
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(homeViewModel.portfolioCoins) { coin in
                CoinRow(coin: coin, showHoldingsColumn: true)
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
    
    private var titles: some View {
        HStack {
            Text("Moneda")
            Spacer()
            if showPortfolio {
                Text("Inversión")
            }
            Text("Precio")
                .frame(width: width / 3, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(.dcSecondaryText)
        .padding(.horizontal, 36)
    }
}

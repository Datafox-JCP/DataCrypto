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
    @State private var showPortfolio = false
    
    // MARK: - View
    var body: some View {
        ZStack {
            Color.dcBackground
                .ignoresSafeArea()
            
            VStack {
                homeHeader
//                List {
//                    CoinRow(coin: MockData.coin, showHoldingsColumn: false)
//                }
                // 2 Una vez que se tenga el init el View Model cambiar a:
                
//                List {
//                    ForEach(homeViewModel.allCoins) { coin in
//                        CoinRow(coin: coin, showHoldingsColumn: false)
//                    }
//                }
                
                // 3 reemplazar por
                
//                if !showPortfolio {
//                    List {
//                        ForEach(homeViewModel.allCoins) { coin in
//                            CoinRow(coin: coin, showHoldingsColumn: false)
//                                .listRowInsets(.init(top: 12, leading: 0, bottom: 12, trailing: 12))
//                        }
//                    }
//                    .listStyle(.plain)
//                    .transition(.move(edge: .leading))
//                }
                
                // 5
//                HStack {
//                    Text("Moneda")
//                    Spacer()
//                    Text("Inversión")
//                    Text("Precio")
//                        .frame(width: width / 3, alignment: .trailing)
//                }
//                .font(.caption)
//                .foregroundStyle(.dcSecondaryText)
//                .padding(.horizontal)
                // 6 cambiar a
                titles
                
                // 4 reemplazar lo anterior por
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            } // VStack
        } // ZStack
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
        List {
            ForEach(homeViewModel.allCoins) { coin in
                CoinRow(coin: coin, showHoldingsColumn: false)
//                    .listRowInsets(.init(top: 12, leading: 0, bottom: 12, trailing: 12))
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(homeViewModel.portfolioCoins) { coin in
                CoinRow(coin: coin, showHoldingsColumn: true)
//                    .listRowInsets(.init(top: 12, leading: 0, bottom: 12, trailing: 12))
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
        .padding(.horizontal)
    }
}

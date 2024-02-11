//
//  HomeView.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 11/02/24.
//

import SwiftUI

struct HomeView: View {
    
    ///  2. Definir variables
    @State private var showPortfolio = false
    
    var body: some View {
        ZStack {
            /// Background layer
            Color.dcBackground
                .ignoresSafeArea()
            
            /// Content layer
            VStack {
                homeHeader
                /// homeHeader va al final primero se crea el HStack aquí
                
                Spacer(minLength: 0)
            }
        } // ZStack
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .toolbar(.hidden)
    }
}

extension HomeView {
    
    private var homeHeader: some View {
            /// 1 Primero añadir los botones y el texto
            HStack {
//                    CircleButton(iconName: "info")
                /// 5 comentar la anterior y usar esto
                CircleButton(iconName: showPortfolio ? "plus" : "info")
                    .animation(.none, value: showPortfolio)
                /// 8
                    .background(
                        CircleButtonAnimation(animate: $showPortfolio)
                    )
                /// 9 separar en extension todo el HStack
                
                Spacer()
                
//                    Text("Precios Actuales")
                /// 6 comentar la anterior y usar y añadir animation al final
                Text(showPortfolio ? "Portafolio" : "Precios Actuales")
                    .fontWeight(.heavy)
                    .foregroundStyle(.accent)
                    .animation(.none, value: showPortfolio)
                /// 7 crear CircleButtonAnimation
                
                Spacer()
                
                CircleButton(iconName: "chevron.right")
                /// 4
                    .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                /// 3
                    .onTapGesture {
                        withAnimation(.interactiveSpring()) {
                            showPortfolio.toggle()
                        }
                    }
            }
            .padding(.horizontal)
    }
}

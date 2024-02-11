//
//  ContentView.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 10/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.dcBackground
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("Accent")
                    .foregroundStyle(.accent)
                
                Text("Secondary")
                    .foregroundStyle(.dcSecondaryText)
                
                Text("Red")
                    .foregroundStyle(.dcRed)
                
                Text("Green")
                    .foregroundStyle(.dcGreen)
            }
            .font(.title)
        }
    }
}

#Preview {
    ContentView()
}

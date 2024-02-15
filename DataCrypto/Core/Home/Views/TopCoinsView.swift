//
//  TopCoinsView.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 14/02/24.
//

import SwiftUI

struct TopCoinsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            // Image
            Image(systemName: "bitcoinsign.circle.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .foregroundColor(.orange)
                .padding(.bottom, 8)
            
//            // Coin info
            HStack(spacing: 2) {
               Text("BTC")
                    .font(.caption)
                    .bold()
                
                Text("$20,330,999.00")
                    .font(.caption)
                    .foregroundStyle(.dcSecondaryText)
            }
//            
            // Coint percent change
            Text("+ 5.6%")
                .foregroundStyle(.dcGreen)
        }
        .frame(width: 140, height: 140)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray4), lineWidth: 2)
        }
    }
}

#Preview {
    TopCoinsView()
}

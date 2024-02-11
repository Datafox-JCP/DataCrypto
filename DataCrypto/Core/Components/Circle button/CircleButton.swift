//
//  CircleButton.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 11/02/24.
//

import SwiftUI

struct CircleButton: View {
    
    // MARK: Properties
    
    let iconName: String
    
    // MARK: View
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(.accent)
            .frame(width: 32, height: 32)
            .background(
                Circle()
                    .foregroundStyle(.background)
            )
            .shadow(
                color: .accent.opacity(0.25),
                radius: 10, x: 0, y: 0
            )
            .padding()
    }
}

// MARK: - Previews
#Preview("Light", traits: .sizeThatFitsLayout) {
    CircleButton(iconName: "info")
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    CircleButton(iconName: "info")
        .preferredColorScheme(.dark)
}

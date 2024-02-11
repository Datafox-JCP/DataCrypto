//
//  Color+Extension.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 10/02/24.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("DCBackgroundColor")
    let green = Color("DCGreenColor")
    let red = Color("DCRedColor")
    let secondaryText = Color("DCSecondaryTextColor")
}

struct DemoColorTheme: View {
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("Accent")
                    .foregroundStyle(Color.theme.accent)
                
                Text("Secondary")
                    .foregroundStyle(Color.theme.secondaryText)
                
                Text("Red")
                    .foregroundStyle(Color.theme.red)
                
                Text("Green")
                    .foregroundStyle(Color.theme.green)
            }
            .font(.title)
        }
    }
}

#Preview {
    DemoColorTheme()
}

//
//  CircleButtonAnimation.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 11/02/24.
//

import SwiftUI

struct CircleButtonAnimation: View {
    
    // MARK: Properties
//    @State private var animate = false /// 2
    @Binding var animate: Bool /// 6 cambiar a esta
    
    
        // MARK: - View
    var body: some View {
        Circle() /// 1
            .stroke(lineWidth: 5.0) /// 1
            .scale(animate ? 1.0 : 0.0) /// 3
            .opacity(animate ? 0.0 : 1.0) /// 4
            .animation(animate ? Animation.easeInOut(duration: 1.0) : .none, value: animate) /// 2 añadir esta línea y el onAppear
            .onAppear {
                animate.toggle()
            }
    }
}

// MARK: Preview
#Preview {
    CircleButtonAnimation(animate: .constant(false)) /// 6 al usar Binding completar aquí
        /// 5 añadir
        .foregroundStyle(.red)
        .frame(width: 100, height: 100)
}

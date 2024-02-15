//
//  LoadingView.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 15/02/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .scaleEffect(2.0, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .black))
    }
}

#Preview {
    LoadingView()
}

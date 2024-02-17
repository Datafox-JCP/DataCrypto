//
//  CachedImage.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 17/02/24.
//

import SwiftUI

struct CachedImage: View {
    
    @State private var manager = CachedImagesManager()
    
    let url: String
    
    var body: some View {
        ZStack {
            if let data = manager.data,
               let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .aspectRatio(contentMode: .fill)
            } // Loop
        } // ZStack
        .task {
            await manager.load(url)
        }
    }
}

#Preview {
    CachedImage(url: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579")
}

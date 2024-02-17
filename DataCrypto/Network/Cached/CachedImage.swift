//
//  CachedImage.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 17/02/24.
//

import SwiftUI

// 2
// 5 create Memberwise inititializer
struct CachedImage<Content: View>: View {
    
    @StateObject private var manager = CachedImagesManager()
    
    let url: String
    // 4
    let animation: Animation?
    let transition: AnyTransition
    let content: (AsyncImagePhase) -> Content // para el init
    
    // 3
//    @ViewBuilder let content: (AsyncImagePhase) -> Content
    // mover la línea en vez de la generada por el inicializador
    
    init(
        url: String,
        animation: Animation? = nil,
        transition: AnyTransition = .identity,
        @ViewBuilder content: @escaping (AsyncImagePhase) -> Content
    ) {
        self.url = url
        self.animation = animation
        self.transition = transition
        self.content = content
    }
    
    var body: some View {
        ZStack {
            // 1
            switch manager.currentState {
            case .loading:
                content(.empty)
                    .transition(transition) // añadirlos después de animaciones
            case .failed(let error):
                content(.failure(error))
                    .transition(transition)
            case .success(let data):
                if let image = UIImage(data: data) {
                    content(.success(Image(uiImage: image)))
                        .transition(transition)
                } else {
                    content(.failure(CachedImageError.invalidData))
                        .transition(transition)
                }
            default:
                content(.empty)
                    .transition(transition)
            }
        } // ZStack
        .animation(animation, value: manager.currentState)
        .task {
            await manager.load(url)
        }
    }
}

#Preview {
    CachedImage(url: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579") { _ in
        EmptyView() }
}

extension CachedImage {
    enum CachedImageError: Error {
        case invalidData
    }
}

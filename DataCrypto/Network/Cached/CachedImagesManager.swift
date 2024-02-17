//
//  CachedImagesManager.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 16/02/24.
//

import Foundation


final class CachedImagesManager: ObservableObject {
    
    @Published private(set) var currentState: CurrentState?
    
    private let imageRetriver = ImageRetriver()
    
    @MainActor
    func load(_ imageUrl: String,
              cache: ImageCache = .shared) async {
        
        self.currentState = .loading
        
        if let imageData = cache.object(forKey: imageUrl as NSString) {
            self.currentState = .success(data: imageData)
            #if DEBUG
            print("🌇 Fetching image from cache: \(imageUrl)")
            #endif
            return
        }
        
        do {
            let data = try await imageRetriver.fetch(imageUrl)
            
            self.currentState = .success(data: data)
            cache.set(
                object: data as NSData,
                forkey: imageUrl as NSString
            )
            #if DEBUG
            print("📲 Caching image: \(imageUrl)")
            #endif
        } catch {
            self.currentState = .failed(error: error)
            #if DEBUG
            print("😖 There was an error fetching the image: \(error.localizedDescription)")
            #endif
        }
    }
}

// MARK: - Extension
extension CachedImagesManager {
    enum CurrentState {
        case loading
        case failed(error: Error)
        case success(data: Data)
    }
}

// Para animación
extension CachedImagesManager.CurrentState: Equatable {
    static func == (
        lhs: CachedImagesManager.CurrentState,
        rhs: CachedImagesManager.CurrentState) -> Bool {
            switch (lhs, rhs) {
            case (.loading, .loading):
                return true
            case (let .failed(lhsError), let .failed(rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
            case (let .success(lhsData), let .success(rhsData)):
                return lhsData == rhsData
            default:
                return false
            }
        }
}

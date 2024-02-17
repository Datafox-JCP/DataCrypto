//
//  CachedImagesManager.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 16/02/24.
//

import Foundation

@Observable
final class CachedImagesManager {
    
    private(set) var data: Data?
    
    private let imageRetriver = ImageRetriver()
    
    @MainActor
//    func load(_ imageUrl: String) async { // 1
    func load(_ imageUrl: String,
              cache: ImageCache = .shared) async {
        
        // 2 Fetch the image from cache if name exists
        if let imageData = cache.object(forKey: imageUrl as NSString) {
            self.data = imageData
            print("🌇 Fetching image from cache: \(imageUrl)")
            return
        }
        
        do {
            self.data = try await imageRetriver.fetch(imageUrl)
            // 1 Fetch the image and saving on cache
            if let dataToCache = data as? NSData {
                cache.set(object: dataToCache, forkey: imageUrl as NSString)
                print("📲 Caching image: \(imageUrl)")
            }
        } catch {
            print("😖 There was an error fetching the image: \(error.localizedDescription)")
        }
    }
}

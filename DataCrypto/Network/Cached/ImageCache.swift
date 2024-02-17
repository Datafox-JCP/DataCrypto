//
//  ImageCache.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 16/02/24.
//

import Foundation

// Use only an instance of this (singleton)
class ImageCache {
    
    typealias CacheType = NSCache<NSString, NSData>

    static let shared = ImageCache() // 1
    
    private init() {} // 2 This forces to call the shared constant
    
    // 3 not be initialized until is used
    private lazy var cache: CacheType = {
        let cache = CacheType()
        
        cache.countLimit = 250
        cache.totalCostLimit = 50 * 1024 * 1024 // 52428800 Bytes > 50MB
        
        return cache
    }()
    
    // 4
    func object(forKey key: NSString) -> Data? {
        cache.object(forKey: key) as? Data
    }
    
    func set(object: NSData, forkey key: NSString) {
        cache.setObject(object, forKey: key)
    }
}

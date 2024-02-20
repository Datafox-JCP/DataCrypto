//
//  HapticManager.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 20/02/24.
//

import SwiftUI

class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

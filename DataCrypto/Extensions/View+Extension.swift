//
//  View+Extension.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 17/02/24.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

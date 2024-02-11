//
//  DataCryptoApp.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 10/02/24.
//

import SwiftUI

@main
struct DataCryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden)
            }
        }
    }
}

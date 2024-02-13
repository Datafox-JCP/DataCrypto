//
//  Sizes.swift
//  DataCrypto
//
//  Created by Juan Hernandez Pazos on 13/02/24.
//

import SwiftUI

let scenes = UIApplication.shared.connectedScenes
let windowScene = scenes.first as? UIWindowScene
let window = windowScene?.windows.first

let height = window?.screen.bounds.height ?? 0
let width = window?.screen.bounds.width ?? 0
let safeAreaBottom = window?.safeAreaInsets.bottom ?? 0
let safeAreaLeft = window?.safeAreaInsets.left ?? 0
let safeAreaRight = window?.safeAreaInsets.right ?? 0
let safeAreaTop = window?.safeAreaInsets.top ?? 0

//
//  Color.swift
//  CryptoApp
//
//  Created by Mai on 11/07/2024.
//

import Foundation
import SwiftUI
extension Color {
    static let theme = ColorTheme()
}
struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryTextColor = Color("SecondaryTextColor")
}

//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Mai on 30/08/2024.
//

import Foundation
import SwiftUI
extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

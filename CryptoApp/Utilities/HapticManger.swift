//
//  HapticManger.swift
//  CryptoApp
//
//  Created by Mai on 15/11/2024.
//

import Foundation
import SwiftUI
class HapticManger {
    private init() {}
    static private let generator = UINotificationFeedbackGenerator()
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

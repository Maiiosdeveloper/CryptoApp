//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Mai on 12/07/2024.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    @Binding var animate: Bool
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0 : 1)
            .animation(animate ? .easeIn(duration: 1.0) : .none, value: animate)
            
    }
}

#Preview {
    CircleButtonAnimationView(animate: .constant(true))
}

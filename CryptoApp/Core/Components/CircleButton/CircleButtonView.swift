//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Mai on 11/07/2024.
//

import SwiftUI

struct CircleButtonView: View {
    let iconName: String
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(.theme.accent)
            .font(.headline)
            .frame(width: 50, height: 50)
            .background {
                Circle()
                    .foregroundColor(.theme.background)
                    .shadow(
                        color: .theme.accent.opacity(0.25),
                        radius: 10)
            }
            .padding()
            
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonView(iconName: "heart.fill")
        
}

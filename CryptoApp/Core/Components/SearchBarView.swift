//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Mai on 20/08/2024.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String 
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    text.isEmpty ? .theme.secondaryTextColor : .theme.accent
                )
            TextField("Search by name or symbol...", text: $text)
                .autocorrectionDisabled()
                .foregroundStyle(Color.theme.accent)
                .padding(.trailing)
            
                
        }
        
        .font(.headline)
        .padding()
        
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill( Color.theme.background)
                .shadow(
                    color: .theme.secondaryTextColor.opacity(0.3), radius: 10, x:0, y:0)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark")
                        .padding()
                        .opacity(text.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.dismissKeyboard()
                            text = ""
                        }
                }
                
        }
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(text: .constant(""))
}

//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Mai on 27/10/2024.
//

import SwiftUI

struct XMarkButton: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButton()
}

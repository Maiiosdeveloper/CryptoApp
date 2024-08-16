//
//  CoinImageView.swift
//  CryptoApp
//
//  Created by Mai on 13/08/2024.
//

import SwiftUI

struct CoinImageView: View {
    
    @StateObject var viewModel: CoinImageViewModel
    
    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image).resizable().scaledToFit()
            }else if viewModel.isLoadinng {
                ProgressView()
            }else {
                Image(systemName: "questionmark").foregroundColor(Color.theme.secondaryTextColor)
                    
            }
            
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinImageView(viewModel: .init(id: "1"))
}

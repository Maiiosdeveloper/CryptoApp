//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by Mai on 29/10/2024.
//

import SwiftUI

struct CoinLogoView: View {
    let coin: CoinModel
    var body: some View {
        
        VStack {
            CoinImageView(viewModel: .init(id: "\(coin.id)"))
                .frame(width: 60, height: 60)
                .cornerRadius(30)
            Text(coin.symbol ?? "")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1,reservesSpace: true)
            Text(coin.name ?? "")
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryTextColor)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .padding()
//        .background {
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(Color.theme.green, lineWidth: 1)
//        }
        
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: DeveloperPreview.instance.coinModel)
}

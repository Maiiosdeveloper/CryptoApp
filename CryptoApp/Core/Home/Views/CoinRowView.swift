//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Mai on 13/07/2024.
//

import SwiftUI

struct CoinRowView: View {
    let model: CoinModel
    let showHoldings: Bool
    var body: some View {
        HStack {
            leftColummn
            Spacer()
            if showHoldings {
                centerColummn
            }
            rightColummn
        }
        .font(.subheadline)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(model: DeveloperPreview.instance.coinModel , showHoldings: true)
}
extension CoinRowView {
    private var leftColummn: some View {
        HStack {
            Text("\(model.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)
            CoinImageView(viewModel: .init(id: "\(model.id)")).frame(width: 30, height: 30)
            Text("\(model.symbol?.uppercased() ?? "")")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                
                
                
        }
    }
    private var centerColummn: some View {
        VStack(alignment: .trailing) {
            Text(model.currentHoldingsValue.addCurrency)
                .bold()
            Text((model.currentHoldings ?? 0).addReadableNummber)
        }
        .foregroundStyle(Color.theme.accent)
    }
    private var rightColummn: some View {
        VStack(alignment: .trailing) {
            Text((model.quote?.usd?.price ?? 0).addCurrency)
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text((model.quote?.usd?.percentChange24H ?? 0).addPercentage)
                .foregroundStyle((model.quote?.usd?.percentChange24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red)
        }
        .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
    }
}

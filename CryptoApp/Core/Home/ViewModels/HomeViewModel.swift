//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Mai on 18/07/2024.
//

import Foundation
class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3) { [weak self] in
            guard let self else { return }
            allCoins.append(DeveloperPreview.instance.coinModel)
            portfolioCoins.append(DeveloperPreview.instance.coinModel)
        }
    }
}

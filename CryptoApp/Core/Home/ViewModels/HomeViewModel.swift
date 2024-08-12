//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Mai on 18/07/2024.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    init() {
        addSubscribers()
    }
    func addSubscribers() {
        dataService.$allCoins
            .sink { [weak self] coinsModel in
            guard let self else { return }
            allCoins = coinsModel
            }
            .store(in: &cancellables)
    }
}

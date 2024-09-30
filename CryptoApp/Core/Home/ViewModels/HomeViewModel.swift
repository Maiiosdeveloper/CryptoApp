//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Mai on 18/07/2024.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = [
        StatisticModel(title: "Market Coin", value: "$15Bn", percentageChange: 45),
        StatisticModel(title: "Total Value", value: "$50Tr", percentageChange: 0),
        StatisticModel(title: "Profile Value", value: "$150.0K", percentageChange: -15),
        StatisticModel(title: "Profile Value", value: "$150.0K", percentageChange: -15)
   ]
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    init() {
        addSubscribers()
    }
    private func addSubscribers() {
//        dataService.$allCoins
//            .sink { [weak self] coinsModel in
//                guard let self else { return }
//                allCoins = coinsModel
//            }
//            .store(in: &cancellables)
        $searchText.combineLatest(dataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coinsModel in
                guard let self else { return }
                allCoins = coinsModel
            }.store(in: &cancellables)
    }
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        let lowerCasedText = text.lowercased()
        return coins.filter {
            ($0.name ?? "").lowercased().contains(lowerCasedText) ||
            ($0.symbol ?? "").lowercased().contains(lowerCasedText)
        }
    }
}

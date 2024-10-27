//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Mai on 18/07/2024.
//

import Foundation
import Combine
class HomeViewModel: ObservableObject {
    @Published var statistics: [StatisticModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
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
        $searchText.combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] coinsModel in
                guard let self else { return }
                allCoins = coinsModel
            }
            .store(in: &cancellables)
        
        marketDataService.$marketDataModel
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStatistics in
                guard let self else { return }
                statistics = returnedStatistics
            }
            .store(in: &cancellables)
    }
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else { return coins }
        let lowerCasedText = text.lowercased()
        return coins.filter {
            ($0.name ?? "").lowercased().contains(lowerCasedText) ||
            ($0.symbol ?? "").lowercased().contains(lowerCasedText)
        }
    }
    private func mapGlobalMarketData(data: MarketDataModel?) -> [StatisticModel] {
        var statistics: [StatisticModel] = []
        guard let data else { return statistics }
        let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange: data.quote?.usd?.stablecoin24HPercentageChange ?? 0)
        let volume = StatisticModel(title: "24h Volume", value: data.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominancePercentage)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        statistics.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return statistics
    }
}

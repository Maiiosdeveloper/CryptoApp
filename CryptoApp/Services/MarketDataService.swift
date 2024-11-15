//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Mai on 17/10/2024.
//

import Foundation
import Combine
class MarketDataService: ObservableObject {
    @Published var marketDataModel: MarketDataModel?
    // var cancellables = Set<AnyCancellable>()
    var marketDataSubscribtion: AnyCancellable?
    init() {
        getMarketData()
    }
    func getMarketData() {
        guard let url = URL(string: "https://pro-api.coinmarketcap.com/v1/global-metrics/quotes/latest") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("c5e00d48-db5d-4a66-b531-2ca142596ab0", forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        marketDataSubscribtion = NetworkingManager.download(url: request)
            .decode(type: GlobalDataModel.self, decoder: JSONDecoder())
            .sink { NetworkingManager.handleCompletion(completion: $0) }
    receiveValue: { [weak self] viewModel in
        guard let self else { return }
        marketDataModel = viewModel.data
        
        print(marketDataModel)
        marketDataSubscribtion?.cancel()
    }
        
        
        
        
    }
}


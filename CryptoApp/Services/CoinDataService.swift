//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Mai on 03/08/2024.
//

import Foundation
import Combine
class CoinDataService: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    // var cancellables = Set<AnyCancellable>()
    var coinSubscribtion: AnyCancellable?
    init() {
        getCoins()
    }
    private func getCoins() {
        guard let url = URL(string: "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=10&convert=USD") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("c5e00d48-db5d-4a66-b531-2ca142596ab0", forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        coinSubscribtion = URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { (output) -> Data in
                // check if response if good data or not
                // check also if the httpresponse has a status ccode
                guard let response = output.response as? HTTPURLResponse,  response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: CoinModelFullResponse.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(String(describing: error))
                }
            } receiveValue: { [weak self] viewModel in
                guard let self else { return }
                allCoins = viewModel.data
                // because I knoow very well this request get only one data for one request so I can cancel it after getting data
                coinSubscribtion?.cancel()
            }
            

            

    }
}

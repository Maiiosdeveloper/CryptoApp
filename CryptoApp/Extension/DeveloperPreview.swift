//
//  PreviewProvider.swift
//  CryptoApp
//
//  Created by Mai on 13/07/2024.
//

import Foundation
import SwiftUI
//extension PreviewProvider {
//    static var dev: DeveloperPreview {
//        DeveloperPreview.instance
//    }
//}
/*
    this class to add all data we use in previews for swiftui views
 */

class DeveloperPreview {
    
    
    static let instance = DeveloperPreview()
    // to ensure no one can create another instances just one
    private init() { }
    
    let statistic1 = StatisticModel(title: "Market Coin", value: "$15Bn", percentageChange: 45)
    let statistic2 = StatisticModel(title: "Total Value", value: "$50Tr", percentageChange: 0)
    let statistic3 = StatisticModel(title: "Profile Value", value: "$150.0K", percentageChange: -15)
    
    let coinModel: CoinModel = .init(id: 1, name: "Bitcoin", symbol: "BTC", slug: "bitcoin", numMarketPairs: 11597, dateAdded: "2010-07-13T00:00:00.000Z", tags: [
        "mineable",
        "pow",
        "sha-256"
    ], maxSupply: 21000000, circulatingSupply: 19720150, totalSupply: 19720150, infiniteSupply: false, cmcRank: 1, lastUpdated: "2024-07-13T00:50:00.000Z", quote: .init(usd: .init(price: 57834.22008897668, volume24H: 25258411783.75756, volumeChange24H: -12.6058, percentChange1H: -0.11161523, percentChange24H: 0.5552476, percentChange7D: 2.02211133, percentChange30D: -15.31652716, percentChange60D: -7.8956705, percentChange90D: -9.5468542, marketCap: 1140499495287.6335, marketCapDominance: 53.2482, fullyDilutedMarketCap: 1214518621868.51, lastUpdated: "2024-07-13T00:50:00.000Z")))
    
    let homeViewModel: HomeViewModel = .init()
}


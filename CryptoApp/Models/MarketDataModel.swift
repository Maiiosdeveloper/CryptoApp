//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Mai on 16/10/2024.
//

import Foundation
// JSON Data:
/*
 JSON URL:
    https://pro-api.coinmarketcap.com/v1/global-metrics/quotes/latest
 JSON Response:
 {
     "status": {
         "timestamp": "2024-10-16T00:21:56.668Z",
         "error_code": 0,
         "error_message": null,
         "elapsed": 11,
         "credit_count": 1,
         "notice": null
     },
     "data": {
         "active_cryptocurrencies": 9915,
         "total_cryptocurrencies": 31735,
         "active_market_pairs": 86748,
         "active_exchanges": 751,
         "total_exchanges": 9394,
         "eth_dominance": 13.585559193657,
         "btc_dominance": 57.396428129187,
         "eth_dominance_yesterday": 13.77706373,
         "btc_dominance_yesterday": 56.83310653,
         "eth_dominance_24h_percentage_change": -0.191504536343,
         "btc_dominance_24h_percentage_change": 0.563321599187,
         "defi_volume_24h": 6020037102.769765,
         "defi_volume_24h_reported": 33828663613.90772,
         "defi_market_cap": 65782229344.982956,
         "defi_24h_percentage_change": 24.975982455244,
         "stablecoin_volume_24h": 98492755172.60101,
         "stablecoin_volume_24h_reported": 592209452438.0969,
         "stablecoin_market_cap": 165354769024.52332,
         "stablecoin_24h_percentage_change": 13.606767070602,
         "derivatives_volume_24h": 1010369198476.7046,
         "derivatives_volume_24h_reported": 1028682157383.2538,
         "derivatives_24h_percentage_change": 16.881996138304,
         "quote": {
             "USD": {
                 "total_market_cap": 2304896836510.4614,
                 "total_volume_24h": 107437681371.3,
                 "total_volume_24h_reported": 610903694432.64,
                 "altcoin_volume_24h": 58736769191.67987,
                 "altcoin_volume_24h_reported": 342186635206.97107,
                 "altcoin_market_cap": 981968380290.8373,
                 "defi_volume_24h": 6020037102.769765,
                 "defi_volume_24h_reported": 33828663613.90772,
                 "defi_24h_percentage_change": 24.975982455244,
                 "defi_market_cap": 65782229344.982956,
                 "stablecoin_volume_24h": 98492755172.60101,
                 "stablecoin_volume_24h_reported": 592209452438.0969,
                 "stablecoin_24h_percentage_change": 13.606767070602,
                 "stablecoin_market_cap": 165354769024.52332,
                 "derivatives_volume_24h": 1010369198476.7046,
                 "derivatives_volume_24h_reported": 1028682157383.2538,
                 "derivatives_24h_percentage_change": 16.881996138304,
                 "total_market_cap_yesterday": 2298034759318.0483,
                 "total_volume_24h_yesterday": 95289470719.45,
                 "total_market_cap_yesterday_percentage_change": 0.2986063271927861,
                 "total_volume_24h_yesterday_percentage_change": 12.748743969432482,
                 "last_updated": "2024-10-16T00:19:59.999Z"
             }
         },
         "last_updated": "2024-10-16T00:19:59.999Z"
     }
 }
 */
// MARK: - GlobalDataModel
struct GlobalDataModel: Codable {
    let status: Status
    let data: MarketDataModel
}

// MARK: - MarketDataModel
struct MarketDataModel: Codable {
    let activeCryptocurrencies, totalCryptocurrencies, activeMarketPairs, activeExchanges: Int?
    let totalExchanges: Int?
    let ethDominance, btcDominance, ethDominanceYesterday, btcDominanceYesterday: Double?
    let ethDominance24HPercentageChange, btcDominance24HPercentageChange, defiVolume24H, defiVolume24HReported: Double?
    let defiMarketCap, defi24HPercentageChange, stablecoinVolume24H, stablecoinVolume24HReported: Double?
    let stablecoinMarketCap, stablecoin24HPercentageChange, derivativesVolume24H, derivativesVolume24HReported: Double?
    let derivatives24HPercentageChange: Double?
    let quote: Quote?
    let lastUpdated: String?

    enum CodingKeys: String, CodingKey {
        case activeCryptocurrencies = "active_cryptocurrencies"
        case totalCryptocurrencies = "total_cryptocurrencies"
        case activeMarketPairs = "active_market_pairs"
        case activeExchanges = "active_exchanges"
        case totalExchanges = "total_exchanges"
        case ethDominance = "eth_dominance"
        case btcDominance = "btc_dominance"
        case ethDominanceYesterday = "eth_dominance_yesterday"
        case btcDominanceYesterday = "btc_dominance_yesterday"
        case ethDominance24HPercentageChange = "eth_dominance_24h_percentage_change"
        case btcDominance24HPercentageChange = "btc_dominance_24h_percentage_change"
        case defiVolume24H = "defi_volume_24h"
        case defiVolume24HReported = "defi_volume_24h_reported"
        case defiMarketCap = "defi_market_cap"
        case defi24HPercentageChange = "defi_24h_percentage_change"
        case stablecoinVolume24H = "stablecoin_volume_24h"
        case stablecoinVolume24HReported = "stablecoin_volume_24h_reported"
        case stablecoinMarketCap = "stablecoin_market_cap"
        case stablecoin24HPercentageChange = "stablecoin_24h_percentage_change"
        case derivativesVolume24H = "derivatives_volume_24h"
        case derivativesVolume24HReported = "derivatives_volume_24h_reported"
        case derivatives24HPercentageChange = "derivatives_24h_percentage_change"
        case quote
        case lastUpdated = "last_updated"
    }
    var marketCap: String {
        if let item = quote?.usd?.totalMarketCap {
            return "$"+item.addFormattedWithAbbreviations
        }
        return ""
    }
    var volume: String {
        if let item = quote?.usd?.totalVolume24H {
            return "$"+item.addFormattedWithAbbreviations
        }
        return ""
    }
    var btcDominancePercentage: String {
        
        return btcDominance?.addPercentage ?? ""
    }
    
}


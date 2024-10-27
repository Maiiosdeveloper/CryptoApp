//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Mai on 12/07/2024.
//

import Foundation
// Coins API
/*
 URL:
    https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=1&convert=USD
 
 JSON Response:
 {
             "id": 1,
             "name": "Bitcoin",
             "symbol": "BTC",
             "slug": "bitcoin",
             "num_market_pairs": 11596,
             "date_added": "2010-07-13T00:00:00.000Z",
             "tags": [
                 "mineable",
                 "pow",
                 "sha-256",
                 "store-of-value",
                 "state-channel",
                 "coinbase-ventures-portfolio",
                 "three-arrows-capital-portfolio",
                 "polychain-capital-portfolio",
                 "binance-labs-portfolio",
                 "blockchain-capital-portfolio",
                 "boostvc-portfolio",
                 "cms-holdings-portfolio",
                 "dcg-portfolio",
                 "dragonfly-capital-portfolio",
                 "electric-capital-portfolio",
                 "fabric-ventures-portfolio",
                 "framework-ventures-portfolio",
                 "galaxy-digital-portfolio",
                 "huobi-capital-portfolio",
                 "alameda-research-portfolio",
                 "a16z-portfolio",
                 "1confirmation-portfolio",
                 "winklevoss-capital-portfolio",
                 "usv-portfolio",
                 "placeholder-ventures-portfolio",
                 "pantera-capital-portfolio",
                 "multicoin-capital-portfolio",
                 "paradigm-portfolio",
                 "bitcoin-ecosystem",
                 "ftx-bankruptcy-estate"
             ],
             "max_supply": 21000000,
             "circulating_supply": 19719987,
             "total_supply": 19719987,
             "infinite_supply": false,
             "platform": null,
             "cmc_rank": 1,
             "self_reported_circulating_supply": null,
             "self_reported_market_cap": null,
             "tvl_ratio": null,
             "last_updated": "2024-07-12T03:49:00.000Z",
             "quote": {
                 "USD": {
                     "price": 56906.581544723034,
                     "volume_24h": 28622213212.092564,
                     "volume_change_24h": 6.4727,
                     "percent_change_1h": -0.7344716,
                     "percent_change_24h": -0.90345229,
                     "percent_change_7d": 3.07082558,
                     "percent_change_30d": -15.51622714,
                     "percent_change_60d": -6.7735749,
                     "percent_change_90d": -14.99934421,
                     "market_cap": 1122197048276.3782,
                     "market_cap_dominance": 53.2285,
                     "fully_diluted_market_cap": 1195038212439.18,
                     "tvl": null,
                     "last_updated": "2024-07-12T03:49:00.000Z"
                 }
             }
         }
 
 */
// MARK: - CoinModelFullResponse
struct CoinModelFullResponse: Codable {
    let status: Status
    let data: [CoinModel]
}
// MARK: - Status
struct Status: Codable {
    let timestamp: String
    let errorCode: Int
    let elapsed, creditCount: Int
    enum CodingKeys: String, CodingKey {
        case timestamp
        case errorCode = "error_code"
        case elapsed
        case creditCount = "credit_count"
    }
}
// MARK: - CoinModel
struct CoinModel: Identifiable, Codable {
    let id: Int
    let name, symbol, slug: String?
    let numMarketPairs: Int?
    let dateAdded: String?
    let tags: [String]?
    let maxSupply, circulatingSupply, totalSupply: Double?
    let infiniteSupply: Bool?
    // let platform: NSNull?
    let cmcRank: Int?
    // let selfReportedCirculatingSupply, selfReportedMarketCap, tvlRatio: NSNull?
    let lastUpdated: String?
    let quote: Quote?
    var currentHoldings: Double?
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, slug
        case numMarketPairs = "num_market_pairs"
        case dateAdded = "date_added"
        case tags
        case maxSupply = "max_supply"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case infiniteSupply = "infinite_supply"
        // case platform
        case cmcRank = "cmc_rank"
        // case selfReportedCirculatingSupply = "self_reported_circulating_supply"
        // case selfReportedMarketCap = "self_reported_market_cap"
        // case tvlRatio = "tvl_ratio"
        case lastUpdated = "last_updated"
        case quote
    }
    var logoURL: String {
        "https://s2.coinmarketcap.com/static/img/coins/64x64/\(id).png"
    }
    var currentHoldingsValue: Double {
        (currentHoldings ?? 0) * (quote?.usd?.price ?? 0)
    }
    var rank: Int {
        cmcRank ?? 0
    }
    func updateHoldings(amount: Double) -> CoinModel {
        return CoinModel(id: id, name: name, symbol: symbol, slug: slug, numMarketPairs: numMarketPairs, dateAdded: dateAdded, tags: tags, maxSupply: maxSupply, circulatingSupply: circulatingSupply, totalSupply: totalSupply, infiniteSupply: infiniteSupply, cmcRank: cmcRank, lastUpdated: lastUpdated, quote: quote, currentHoldings: amount)
    }
}

// MARK: - Quote
struct Quote:  Codable {
    let usd: Usd?
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

// MARK: - Usd
struct Usd:  Codable {
    let price, volume24H, volumeChange24H, percentChange1H: Double?
    let percentChange24H, percentChange7D, percentChange30D, percentChange60D: Double?
    let percentChange90D, marketCap, marketCapDominance, fullyDilutedMarketCap: Double?
    // let tvl: NSNull?
    let lastUpdated: String?
    
    let totalMarketCap, totalVolume24H, totalVolume24HReported, altcoinVolume24H: Double?
    let altcoinVolume24HReported, altcoinMarketCap, defiVolume24H, defiVolume24HReported: Double?
    let defi24HPercentageChange, defiMarketCap, stablecoinVolume24H, stablecoinVolume24HReported: Double?
    let stablecoin24HPercentageChange, stablecoinMarketCap, derivativesVolume24H, derivativesVolume24HReported: Double?
    let derivatives24HPercentageChange, totalMarketCapYesterday, totalVolume24HYesterday, totalMarketCapYesterdayPercentageChange: Double?
    let totalVolume24HYesterdayPercentageChange: Double?
    enum CodingKeys: String, CodingKey {
        case price
        case volume24H = "volume_24h"
        case volumeChange24H = "volume_change_24h"
        case percentChange1H = "percent_change_1h"
        case percentChange24H = "percent_change_24h"
        case percentChange7D = "percent_change_7d"
        case percentChange30D = "percent_change_30d"
        case percentChange60D = "percent_change_60d"
        case percentChange90D = "percent_change_90d"
        case marketCap = "market_cap"
        case marketCapDominance = "market_cap_dominance"
        case fullyDilutedMarketCap = "fully_diluted_market_cap"
        // case tvl
        case lastUpdated = "last_updated"
        
        case totalMarketCap = "total_market_cap"
        case totalVolume24H = "total_volume_24h"
        case totalVolume24HReported = "total_volume_24h_reported"
        case altcoinVolume24H = "altcoin_volume_24h"
        case altcoinVolume24HReported = "altcoin_volume_24h_reported"
        case altcoinMarketCap = "altcoin_market_cap"
        case defiVolume24H = "defi_volume_24h"
        case defiVolume24HReported = "defi_volume_24h_reported"
        case defi24HPercentageChange = "defi_24h_percentage_change"
        case defiMarketCap = "defi_market_cap"
        case stablecoinVolume24H = "stablecoin_volume_24h"
        case stablecoinVolume24HReported = "stablecoin_volume_24h_reported"
        case stablecoin24HPercentageChange = "stablecoin_24h_percentage_change"
        case stablecoinMarketCap = "stablecoin_market_cap"
        case derivativesVolume24H = "derivatives_volume_24h"
        case derivativesVolume24HReported = "derivatives_volume_24h_reported"
        case derivatives24HPercentageChange = "derivatives_24h_percentage_change"
        case totalMarketCapYesterday = "total_market_cap_yesterday"
        case totalVolume24HYesterday = "total_volume_24h_yesterday"
        case totalMarketCapYesterdayPercentageChange = "total_market_cap_yesterday_percentage_change"
        case totalVolume24HYesterdayPercentageChange = "total_volume_24h_yesterday_percentage_change"
    }
    init(price: Double?, volume24H: Double?, volumeChange24H: Double?, percentChange1H: Double?, percentChange24H: Double?, percentChange7D: Double?, percentChange30D: Double?, percentChange60D: Double?, percentChange90D: Double?, marketCap: Double?, marketCapDominance: Double?, fullyDilutedMarketCap: Double?, lastUpdated: String?, totalMarketCap: Double? = nil, totalVolume24H: Double? = nil, totalVolume24HReported: Double? = nil, altcoinVolume24H: Double? = nil, altcoinVolume24HReported: Double? = nil, altcoinMarketCap: Double? = nil, defiVolume24H: Double? = nil, defiVolume24HReported: Double? = nil, defi24HPercentageChange: Double? = nil, defiMarketCap: Double? = nil, stablecoinVolume24H: Double? = nil, stablecoinVolume24HReported: Double? = nil, stablecoin24HPercentageChange: Double? = nil, stablecoinMarketCap: Double? = nil, derivativesVolume24H: Double? = nil, derivativesVolume24HReported: Double? = nil, derivatives24HPercentageChange: Double? = nil, totalMarketCapYesterday: Double? = nil, totalVolume24HYesterday: Double? = nil, totalMarketCapYesterdayPercentageChange: Double? = nil, totalVolume24HYesterdayPercentageChange: Double? = nil) {
        self.price = price
        self.volume24H = volume24H
        self.volumeChange24H = volumeChange24H
        self.percentChange1H = percentChange1H
        self.percentChange24H = percentChange24H
        self.percentChange7D = percentChange7D
        self.percentChange30D = percentChange30D
        self.percentChange60D = percentChange60D
        self.percentChange90D = percentChange90D
        self.marketCap = marketCap
        self.marketCapDominance = marketCapDominance
        self.fullyDilutedMarketCap = fullyDilutedMarketCap
        self.lastUpdated = lastUpdated
        self.totalMarketCap = totalMarketCap
        self.totalVolume24H = totalVolume24H
        self.totalVolume24HReported = totalVolume24HReported
        self.altcoinVolume24H = altcoinVolume24H
        self.altcoinVolume24HReported = altcoinVolume24HReported
        self.altcoinMarketCap = altcoinMarketCap
        self.defiVolume24H = defiVolume24H
        self.defiVolume24HReported = defiVolume24HReported
        self.defi24HPercentageChange = defi24HPercentageChange
        self.defiMarketCap = defiMarketCap
        self.stablecoinVolume24H = stablecoinVolume24H
        self.stablecoinVolume24HReported = stablecoinVolume24HReported
        self.stablecoin24HPercentageChange = stablecoin24HPercentageChange
        self.stablecoinMarketCap = stablecoinMarketCap
        self.derivativesVolume24H = derivativesVolume24H
        self.derivativesVolume24HReported = derivativesVolume24HReported
        self.derivatives24HPercentageChange = derivatives24HPercentageChange
        self.totalMarketCapYesterday = totalMarketCapYesterday
        self.totalVolume24HYesterday = totalVolume24HYesterday
        self.totalMarketCapYesterdayPercentageChange = totalMarketCapYesterdayPercentageChange
        self.totalVolume24HYesterdayPercentageChange = totalVolume24HYesterdayPercentageChange
    }
}

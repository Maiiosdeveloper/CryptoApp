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
 
// MARK: - CoinModel
struct CoinModel: Identifiable, Codable {
    let id: Int
    let name, symbol, slug: String?
    let numMarketPairs: Int?
    let dateAdded: String?
    let tags: [String]?
    let maxSupply, circulatingSupply, totalSupply: Int?
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
    }
}

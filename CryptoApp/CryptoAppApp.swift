//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Mai on 08/07/2024.
//

import SwiftUI
/*
 CoinMarketCap.com API
 X-CMC_PRO_API_KEY: c5e00d48-db5d-4a66-b531-2ca142596ab0
 Logo URL: https://s2.coinmarketcap.com/static/img/coins/64x64/1.png
 */
@main
struct CryptoAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
            }
            
        }
    }
}

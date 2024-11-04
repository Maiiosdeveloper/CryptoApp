//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Mai on 27/10/2024.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var amount: String = ""
    @State private var savedSuccess: Bool = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, content: {
                    SearchBarView(text: $viewModel.searchText)
                    coinlogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                    
                })
                
            }
            .onChange(of: viewModel.searchText, { oldValue, newValue in
                if newValue.isEmpty {
                    selectedCoin = nil
                }
            })
            .navigationTitle("Edit Portfolio")
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
                if !amount.isEmpty && !savedSuccess {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            saveeButtonPressed()
                        }, label: {
                            trailingNavSaveButton
                        })
                    }
                }
                
            }
        }
    }
}
extension PortfolioView {
    private var coinlogoList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 4, content: {
                ForEach(viewModel
                    .allCoins) { coin in
                        CoinLogoView(coin: coin).frame(minWidth: 100)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut) {
                                    selectedCoinTapped(coin: coin)
                                    
                                }
                            }
                        
                    }
            })
            .padding(.horizontal, 8)
            
        }
        .scrollIndicators(.hidden)
    }
    private func selectedCoinTapped(coin: CoinModel) {
        selectedCoin = coin
        let portfolioCoin = viewModel.portfolioCoins.first { $0.id == coin.id
        }
        if let portfolioCoin {
            amount = "\(portfolioCoin.currentHoldings ?? 0)"
        }else {
            amount = ""
        }
        
    }
    private func getCurrentValue() -> String {
        ((Double(amount) ?? 0)*(selectedCoin?.quote?.usd?.price ?? 0)).addCurrency
    }
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("current pricc of \(selectedCoin?.symbol ?? ""):")
                Spacer()
                Text((selectedCoin?.quote?.usd?.price ?? 0).addCurrency)
            }
            Divider()
            HStack {
                Text("Amount Holding:")
                Spacer()
                TextField("Ex. 1.4", text: $amount)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("current  Value:")
                Spacer()
                Text(getCurrentValue())
            }
            
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }
    private var trailingNavSaveButton: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark")
            Text("Save")
                .font(.headline)
        }
    }
    private func saveeButtonPressed() {
        guard let selectedCoin else { return }
        viewModel.updatePortfolio(coin: selectedCoin, amount: Double(amount) ?? 0)
        removeSelectedCoin()
        savedSuccess = true
        dismiss()
    }
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}
#Preview {
    PortfolioView( viewModel: DeveloperPreview.instance.homeViewModel)
}

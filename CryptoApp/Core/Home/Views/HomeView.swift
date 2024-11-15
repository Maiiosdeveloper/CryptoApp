//
//  HomeView.swift
//  CryptoApp
//
//  Created by Mai on 11/07/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio: Bool = false //animate right
    @State private var showPortfolioView: Bool = false //new sheet
    @StateObject private var viewModel: HomeViewModel = .init()
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            /* when creating new sheet we create new enviroment
             if we have enviroment object in home view and want that in sheet view we manually add it to thhe new enviroment object in sheet view
             */
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView( viewModel: viewModel)
                }
            // content layer
            VStack {
                homeHeader
                HomeStatisticView( vm: viewModel, showPortfolio: $showPortfolio)
                SearchBarView(text: $viewModel.searchText)
                columnsTitles
                if !showPortfolio {
                    if !viewModel.isLoading {
                        allCoinsList
                            .transition(.move(edge: .leading))
                    }
                    
                }
                if showPortfolio {
                    PortfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                Spacer()
            }
            
        }
        .environmentObject(viewModel)
    }
}

#Preview {
    NavigationView {
        HomeView()
            .environmentObject(DeveloperPreview.instance.homeViewModel)
    }
    
}
extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus":"info")
            .background {
                CircleButtonAnimationView(animate: $showPortfolio)
            }
            .onTapGesture {
                if showPortfolio {
                    showPortfolioView.toggle()
                }
            }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(.degrees(showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
            
        }
        .padding(.horizontal)
    }
    private var columnsTitles: some View {
        HStack {
            Text("Coins")
            Spacer()
            if showPortfolio {
                Text("Holdings")
                
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width/3.5, alignment: .trailing)
            Button {
                withAnimation(.linear(duration: 1)) {
                    viewModel.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360:0), anchor: .center)

        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryTextColor)
        .padding(.horizontal)
    }
    private var allCoinsList: some View {
        List {
            ForEach( viewModel.allCoins) { coin in
                CoinRowView(model: coin, showHoldings: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
    private var PortfolioCoinsList: some View {
        List {
            ForEach( viewModel.portfolioCoins) { coin in
                CoinRowView(model: coin, showHoldings: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
            }
        }
        .listStyle(.plain)
    }
}

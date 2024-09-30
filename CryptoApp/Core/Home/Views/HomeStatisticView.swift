//
//  HomeStatisticView.swift
//  CryptoApp
//
//  Created by Mai on 26/09/2024.
//

import SwiftUI

struct HomeStatisticView: View {
    @StateObject var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    var body: some View {
        HStack(spacing: 0) {
            ForEach(vm.statistics) { statistic in
                StatisticView(statistic: statistic)
                    .frame(width: UIScreen.main.bounds.width/3)
            }
            
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
        
    }
}

#Preview {
    HomeStatisticView( vm: DeveloperPreview.instance.homeViewModel, showPortfolio: .constant(false))
        .environmentObject(DeveloperPreview.instance.homeViewModel)
}

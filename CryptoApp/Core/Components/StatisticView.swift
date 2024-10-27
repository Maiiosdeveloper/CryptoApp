//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Mai on 26/09/2024.
//

import SwiftUI

struct StatisticView: View {
    let statistic: StatisticModel
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(statistic.title)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryTextColor)
            Text("\(statistic.value)")
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(.degrees(statistic.percentageChange ?? 0 >= 0 ? 0 : 180))
                Text(statistic.percentageChange?.addPercentage ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundStyle(statistic.percentageChange ?? 0 >= 0 ? Color.theme.green : Color.theme.red)
            .opacity(statistic.percentageChange != nil ? 1.0 : 0.0)
        }
    }
}

#Preview( traits: .sizeThatFitsLayout){
    StatisticView(statistic: DeveloperPreview.instance.statistic1)
        .preferredColorScheme(.dark)
}
#Preview( traits: .sizeThatFitsLayout){
    StatisticView(statistic: DeveloperPreview.instance.statistic2)
}
#Preview( traits: .sizeThatFitsLayout){
    StatisticView(statistic: DeveloperPreview.instance.statistic3)
}

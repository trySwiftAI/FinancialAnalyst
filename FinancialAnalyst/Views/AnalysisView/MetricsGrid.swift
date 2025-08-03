//
//  MetricsGrid.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/3/25.
//

import SwiftUI

struct MetricsGrid: View {
    let analysis: GeneratedFinancialAnalysis.Analysis
    
    private let gridItems: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: 16),
        count: 2)
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 16) {
            
            if let revenue = analysis.revenue {
                MetricView(
                    title: "Revenue",
                    value: revenue.currencyFormat(),
                    icon: "dollarsign.circle.fill",
                    color: .yellow
                )
            }
            
            if let netIncome = analysis.net_income {
                MetricView(
                    title: "Net Income",
                    value: netIncome.currencyFormat(),
                    icon: "chart.line.uptrend.xyaxis.circle.fill",
                    color: .indigo
                )
            }
            
            if let eps = analysis.eps {
                MetricView(
                    title: "EPS",
                    value: String(format: "$%.2f", eps),
                    icon: "person.crop.circle.fill.badge.plus",
                    color: .orange
                )
            }
            
            if let growth = analysis.revenue_growth_yoy {
                MetricView(
                    title: "YoY Growth",
                    value: String(format: "%.1f%%", growth),
                    icon: "arrow.up.right.circle.fill",
                    color: growth >= 0 ? .green : .red
                )
            }
        }
    }
}

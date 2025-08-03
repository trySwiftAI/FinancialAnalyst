//
//  RevenueGrowthView.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/3/25.
//

import SwiftUI

struct RevenueGrowthView: View {
    let growth: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundColor(.mint)
                    .font(.title2)
                
                Text("Revenue Growth Analysis")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Year-over-Year Growth")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("\(growth, specifier: "%.1f")%")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(growth >= 0 ? .green : .red)
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(.gray.opacity(0.3), lineWidth: 8)
                        .frame(width: 80, height: 80)
                    
                    Circle()
                        .trim(from: 0, to: min(abs(growth) / 100, 1.0))
                        .stroke(growth >= 0 ? .green : .red, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(-90))
                    
                    Text("\(Int(growth))%")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding()
        .background(.regularMaterial, in: ConcentricRectangle(corners: .fixed(12), isUniform: true)
        )
        .overlay(
            ConcentricRectangle(corners: .fixed(12), isUniform: true)
                .stroke(growth >= 0 ? .green.opacity(0.3) : .red.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview("Positive Growth") {
    RevenueGrowthView(growth: 55)
}

#Preview("Negative Growth") {
    RevenueGrowthView(growth: -5)
}

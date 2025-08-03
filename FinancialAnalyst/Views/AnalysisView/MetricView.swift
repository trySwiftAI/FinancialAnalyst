//
//  MetricCard.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/3/25.
//

import SwiftUI

struct MetricView: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                    .font(.title3)
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .padding()
        .background(.regularMaterial, in:
                        ConcentricRectangle(corners: .fixed(12), isUniform: true)
        )
        .overlay(
            ConcentricRectangle(corners: .fixed(12), isUniform: true)
                .stroke(color.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    MetricView(
        title: "Revenue",
        value: "$95",
        icon: "dollarsign.circle.fill",
        color: .orange
    )
}

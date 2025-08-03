//
//  CompanyHeaderView.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/3/25.
//

import SwiftUI

struct CompanyHeaderView: View {
    let company: String
    let quarter: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text(company)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(quarter)
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(.regularMaterial, in:
                        ConcentricRectangle(corners: .fixed(12), isUniform: true)
        )
        .overlay(
            ConcentricRectangle(corners: .fixed(12), isUniform: true)
                .stroke(.mint.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    CompanyHeaderView(company: "Apple, Inc.", quarter: "Q4 FY2025")
}

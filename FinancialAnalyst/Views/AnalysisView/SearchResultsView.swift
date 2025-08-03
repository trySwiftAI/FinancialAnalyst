//
//  SearchResultsView.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/3/25.
//

import SwiftUI

struct SearchResultsView: View {
    let searchResults: [GeneratedFinancialAnalysis.SearchResult]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "link.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title2)
                
                Text("Sources")
                    .font(.title3)
                    .fontWeight(.semibold)
            }

            LazyVStack(spacing: 12) {
                ForEach(searchResults.indices, id: \.self) { index in
                    SearchResultRowView(result: searchResults[index])
                }
            }
            
        }
        .padding()
        .background(.regularMaterial, in: ConcentricRectangle(corners: .fixed(12), isUniform: true)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.blue.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    let searchResult: GeneratedFinancialAnalysis.SearchResult = .init(
        title: "Apple reports second quarter results",
        url: "https://www.apple.com/newsroom/2025/05/apple-reports-second-quarter-results/",
        last_updated: "2025-05-02"
    )
    
    SearchResultsView(searchResults: [searchResult])
}

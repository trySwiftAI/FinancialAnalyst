//
//  SearchResultRowView.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/3/25.
//

import SwiftUI

struct SearchResultRowView: View {
    let result: GeneratedFinancialAnalysis.SearchResult
    
    var body: some View {
        Link(destination: URL(string: result.url ?? "") ?? URL(string: "https://www.apple.com")!) {
            VStack(alignment: .leading, spacing: 4) {
                Text(result.title ?? "Untitled")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .lineLimit(2)
                
                if let url = result.url {
                    Text(url)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                HStack {
                    if let date = result.date {
                        Text(date)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    if let lastUpdated = result.last_updated {
                        Text("Updated: \(lastUpdated)")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding()
        }
        .buttonStyle(.plain)
        .glassEffect(.regular.interactive().tint(.blue.opacity(0.3)), in: .rect(cornerRadius: 12))
    }
}

#Preview {
    let searchResult: GeneratedFinancialAnalysis.SearchResult = .init(
        title: "Apple reports second quarter results",
        url: "https://www.apple.com/newsroom/2025/05/apple-reports-second-quarter-results/",
        last_updated: "2025-05-02"
    )
    SearchResultRowView(result: searchResult)
}



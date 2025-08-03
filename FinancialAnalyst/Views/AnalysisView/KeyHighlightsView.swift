//
//  KeyHighlightsView.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/3/25.
//

import SwiftUI

struct KeyHighlightsView: View {
    let highlights: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Key Highlights")
                .font(.title3)
                .fontWeight(.semibold)
            
            LazyVStack(spacing: 12) {
                ForEach(Array(highlights.enumerated()), id: \.offset) { index, highlight in
                    HStack(alignment: .top, spacing: 12) {
                        Text("\(index + 1)")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .frame(width: 24, height: 24)
                            .glassEffect(.regular.interactive(), in: .circle)
                           .background(.orange, in: Circle())
                        
                        Text(highlight)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                        
                        Spacer()
                    }
                }
            }
        }
        .padding()
        .background(.regularMaterial, in: ConcentricRectangle(corners: .fixed(12), isUniform: true)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.orange.opacity(0.3), lineWidth: 1)
        )
    }
}

#Preview {
    let keyHighlights: [String] = [
        "Q2 FY2025 revenue was $95.4B, up 5% YoY and 5% sequentially from the prior quarter.",
        "Diluted EPS was $1.08, beating consensus estimates.",
        "iPhone revenue grew 2% YoY to $46.8B; Mac revenue rose 7% to $7.95B; iPad revenue jumped 15% to $6.4B; Services revenue grew 12% to a record $26.6B; Wearables/home/accessories fell 5% to $7.5B.",
        "Operating margin and net margin both improved YoY; net income was $23.6B vs. $22.96B YoY.",
        "Operating cash flow was strong; cash and equivalents ended at $28.2B, though down from $33.9B YoY, primarily due to substantial capital returns and higher tax payments.",
        "Americas led regional growth; China was flat-to-down due to macro uncertainty, while Japan and other APAC regions grew strongly.",
        "Management cited all-time-high installed base across major products and robust new customer acquisition in Mac and iPad.",
        "Guidance: Cautiously optimistic for Q3, management expects continued growth in Services, iPad, and Mac, iPhone growth expected to be modest; Services margin strength to persist.",
        "Capital return: Robust share repurchases and dividends continued. Balance sheet remains strong, with manageable debt and high liquidity.",
        "Competitive position: Still leading in premium segments, but faces intensified competition in China and a more mature smartphone cycle."
    ]
    ScrollView {
        KeyHighlightsView(highlights: keyHighlights)
    }
}

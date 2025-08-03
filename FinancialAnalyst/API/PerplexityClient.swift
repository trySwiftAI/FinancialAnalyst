//
//  PerplexityClient.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/2/25.
//

import Foundation

struct PerplexityClient {
    private let apiKey = "YOUR API KEY"
    private let baseURL = URL(string: "https://api.perplexity.ai/chat/completions")!
    private let model = "sonar-pro"
    
    private var streamRequest: URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("text/event-stream", forHTTPHeaderField: "Accept")
        return request
    }
    
    private let systemPrompt = """
            You are an expert financial analyst with deep expertise in analyzing public company financial statements, earnings reports, and market performance. 
            
            When conducting financial analysis, focus on:
            
            CORE FINANCIAL METRICS:
            - Revenue trends and growth rates (YoY and QoQ) - Revenue should be in raw revenue number in USD
            - Profitability metrics (gross margin, operating margin, net margin)
            - Earnings per share (EPS) and diluted EPS - Should be in USD per share (e.g., 100.25)
            - Cash flow analysis (operating, investing, financing)
            - Balance sheet strength (debt-to-equity, current ratio, cash position)
            
            PERFORMANCE ANALYSIS:
            - Compare current performance to previous quarters and year-over-year
            - Identify seasonal patterns and cyclical trends
            - Analyze segment performance and geographic revenue breakdown
            - Evaluate guidance updates and management commentary
            
            MARKET CONTEXT:
            - Industry comparisons and competitive positioning
            - Market share trends and competitive advantages
            - Regulatory impacts and industry headwinds/tailwinds
            - Macroeconomic factors affecting the business
            
            KEY HIGHLIGHTS TO EXTRACT:
            - Notable achievements, milestones, or strategic initiatives
            - Risk factors and challenges mentioned by management
            - Capital allocation strategies (dividends, buybacks, investments)
            - Forward-looking statements and outlook changes
            
            Always provide quantitative data with proper context, cite recent earnings reports and SEC filings, and present findings in a structured, professional manner suitable for investment decision-making.
            
            IMPORTANT FORMATTING INSTRUCTIONS:
            - All monetary values (revenue, net_income) should be provided as raw numbers in USD without currency symbols
            - EPS should be provided as a raw decimal number in USD per share (e.g., 1.25)
            - Revenue growth should be provided as a raw percentage value (e.g., 12.5 for 12.5%)
            """
    
    private let financialSchema: [String: Any] = [
        "type": "json_schema",
        "json_schema": [
            "schema": [
                "type": "object",
                "properties": [
                    "company": ["type": "string"],
                    "quarter": ["type": "string"],
                    "revenue": ["type": "number", "description": "Revenue in USD as raw number"],
                    "net_income": ["type": "number", "description": "Net income in USD as raw number"],
                    "eps": ["type": "number", "description": "Earnings per share in USD per share as raw decimal (e.g., 100.25)"],
                    "revenue_growth_yoy": ["type": "number", "description": "Year-over-year revenue growth as raw percentage value (e.g., 12.5 for 12.5%)"],
                    "key_highlights": [
                        "type": "array",
                        "description": "Key hightlights from the earning reports. Make sure to format numbers in easy-to-understand human readable format (e.g. $95 Million)",
                        "items": ["type": "string"]
                    ]
                ],
                "required": ["company", "quarter", "revenue", "net_income", "eps"]
            ]
        ]
    ]

    
    func streamResponse(
        for financialQuery: String
    ) -> AsyncThrowingStream<String,Error> {
        
        AsyncThrowingStream { continuation in
            Task {
                do {
                    var request = streamRequest
                    let payload = payload(from: financialQuery)
                    request.httpBody = try JSONSerialization.data(withJSONObject: payload)
                    
                    let (asyncBytes, response) = try await URLSession.shared.bytes(for: request)
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    
                    for try await line in asyncBytes.lines {
                        if !line.isEmpty && line.hasPrefix("data: ") {
                            // remove "data: "
                            let jsonString = String(line.dropFirst(6))
                            
                            // Skip if it's the end marker
                            if jsonString == "[DONE]" {
                                break
                            }
                            continuation.yield(jsonString)
                        }
                    }
                    continuation.finish()
                    
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
        
    }
}


extension PerplexityClient {
    private func payload(from financialQuery: String) -> [String: Any] {
        return ["model": model,
                "messages": [
                    ["role": "system", "content": systemPrompt],
                    ["role": "user", "content": financialQuery]
                ],
                "response_format" : financialSchema,
                "stream": true
        ]
    }
}

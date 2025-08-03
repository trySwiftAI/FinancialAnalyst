//
//  InputViewModel.swift
//  FinancialAnalyst
//
//  Created by Natasha Murashev on 8/2/25.
//

import Foundation

@Observable
class InputForm {
    var selectedCompany: Company = .apple
    var selectedTimeframe: Timeframe = .lastQuarter
    var additionalQuestion: String = ""
    
    func reset() {
        selectedCompany = .apple
        selectedTimeframe = .lastQuarter
        additionalQuestion = ""
    }
    
    func generatePrompt() -> String {
        var prompt = "Provide a comprehensive financial analysis for \(selectedCompany.rawValue) covering the following timeframe: \(selectedTimeframe.rawValue)."
        
        switch selectedTimeframe {
        case .lastQuarter:
            prompt += " Focus on the most recent quarterly earnings report, comparing performance to the previous quarter and year-over-year results."
        case .lastYear:
            prompt += " Analyze the full-year financial performance, including annual revenue, profit margins, and key business metrics."
        case .lastTwoYears:
            prompt += " Provide a two-year trend analysis showing how the company's financial performance has evolved, highlighting major changes and growth patterns."
        case .yearToDate:
            prompt += " Analyze the year-to-date performance compared to the same period last year, including quarterly breakdowns if available."
        case .lastSixMonths:
            prompt += " Focus on the most recent six months of financial data, including the latest quarterly results and any interim updates."
        }
        
        // Add company-specific analysis requests
        prompt += "\n\nInclude analysis of:"
        prompt += "\n• Revenue trends and growth drivers"
        prompt += "\n• Profitability metrics and margin analysis"
        prompt += "\n• Cash flow and balance sheet strength"
        prompt += "\n• Key business segments and their performance"
        prompt += "\n• Management guidance and outlook"
        prompt += "\n• Competitive positioning and market share"
        
        // Add any additional questions from the user
        if !additionalQuestion.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            prompt += "\n\nAdditional specific analysis requested: \(additionalQuestion)"
        }
        
        prompt += "\n\nPlease provide quantitative data where available and cite recent SEC filings, earnings reports, and official company communications."
        
        return prompt
    }
}
